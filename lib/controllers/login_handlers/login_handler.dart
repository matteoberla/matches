import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/capo_azz_handlers/capo_azz_handler.dart';
import 'package:matches/controllers/capo_euro_handlers/capo_euro_handler.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/fasi_handlers/fasi_handler.dart';
import 'package:matches/controllers/gironi_handlers/gironi_handler.dart';
import 'package:matches/controllers/goal_veloce_handlers/goal_veloce_handler.dart';
import 'package:matches/controllers/login_handlers/login_requests.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/controllers/persistent_data_handlers/login_shared_preferences.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/team_rivelaz_handlers/team_rivelaz_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/login_provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginHandler {
  Future<bool> initLoginPage(BuildContext context) async {
    await Future.delayed(Duration.zero);

    if (context.mounted) {
      await checkLocalSavedCredentials(context);
    }

    return true;
  }

  checkLocalSavedCredentials(BuildContext context) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    String savedUsername = await LoginSharedPreferences.username;
    String savedPassword = await LoginSharedPreferences.password;

    if (savedUsername != "" && savedPassword != "") {
      loginProvider.updateUsername(savedUsername);
      loginProvider.updatePassword(savedPassword);
      print(
          "Trovate credenziali ${loginProvider.username} ${loginProvider.password}");

      if (context.mounted) {
        await tryLogin(context, loginProvider);
      }
    } else {
      print("Credenziali non trovate -> eseguire login");
    }
  }

  Future<bool> tryLogin(BuildContext context, LoginProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    LoginRequests loginRequests = LoginRequests();

    Map<String, String> params = {
      "email": provider.username,
      "password": provider.password
    };

    http.Response loginResponse = await loginRequests.login(params);

    httpProvider.updateLoadingState(false);
    if (loginResponse.statusCode == 200) {
      LoginModel loginModel =
          LoginModel.fromJson(json.decode(loginResponse.body));

      if (loginModel.message == null) {
        //salvo dati di accesso
        await LoginSharedPreferences.saveAccessInformation(loginModel.token);
        await LoginSharedPreferences.saveLoginCredentials(
            provider.username, provider.password);
        provider.updateCurrentUser(loginModel);

        //inizializzazione dati app
        if (context.mounted) {
          bool initialized = await initializeAllData(context, provider);
          if (initialized && context.mounted) {
            Navigator.popAndPushNamed(context, '/matches');
          }
        }
      } else {
        await LoginSharedPreferences.saveAccessInformation(null);
        await LoginSharedPreferences.saveLoginCredentials(null, null);
        await Alerts.showErrorAlertNoContext(
            "Attenzione!", loginModel.message ?? "Errore generico");
        return false;
      }
    }
    return false;
  }

  Future<bool> initializeAllData(
      BuildContext context, LoginProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    MatchesHandler matchesHandler = MatchesHandler();
    TeamsHandler teamsHandler = TeamsHandler();
    FasiHandler fasiHandler = FasiHandler();
    GironiHandler gironiHandler = GironiHandler();
    PointsHandler pointsHandler = PointsHandler();
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
    TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
    CapoEuroHandler capoEuroHandler = CapoEuroHandler();
    CapoAzzHandler capoAzzHandler = CapoAzzHandler();

    try {
      await Future.wait([
        matchesHandler.saveAllMatches(context),
        matchesHandler.saveAllMatchesBet(context),
        teamsHandler.saveAllTeams(context),
        fasiHandler.saveAllFasi(context),
        gironiHandler.saveAllGironi(context),
        gironiHandler.saveAllGironiBet(context),
        pointsHandler.saveAllPoints(context),
        matchesFinHandler.saveAllMatches(context),
        matchesFinHandler.saveAllMatchesBet(context),
        goalVeloceHandler.saveAllGoalVeloce(context),
        goalVeloceHandler.saveAllGoalVeloceBet(context),
        teamRivelazHandler.saveAllTeamRivelaz(context),
        teamRivelazHandler.saveAllTeamRivelazBet(context),
        capoEuroHandler.saveAllCapoEuroBet(context),
        capoEuroHandler.saveUsersCapoEuroBet(context),
        capoAzzHandler.saveAllCapoAzzBet(context),
        capoAzzHandler.saveUsersCapoAzzBet(context)
      ]);
    } catch (e) {
      print(e);
    }

    httpProvider.updateLoadingState(false);

    return true;
  }

  LoginModel? getCurrentUser(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return loginProvider.currentUser;
  }

  bool currentUserIsAdmin(BuildContext context) {
    return getCurrentUser(context)?.admin == 1;
  }

  Future<bool> resultCanBeEdited(BuildContext context) async {
    LoginModel? currentUser = getCurrentUser(context);
    if (currentUser != null) {
      DateTime? dtScad = DateTimeHandler.getDateTimeFromString(
          currentUser.dtScadenza, DateFormatType.dateAndTime);
      DateTime now = DateTime.now();

      if (dtScad != null) {
        if (now.isBefore(dtScad)) {
          return true;
        } else {
          await Alerts.showInfoAlertNoContext(
              "Attenzione", "Non è più possibile modificare il risultato");
          return false;
        }
      } else {
        await Alerts.showInfoAlertNoContext(
            "Attenzione", "Impossibile leggere la data di compilazione");
        return false;
      }
    }
    return false;
  }
}
