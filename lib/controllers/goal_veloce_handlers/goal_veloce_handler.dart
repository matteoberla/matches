import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/goal_veloce_handlers/goal_veloce_requests.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_bet_model.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_model.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/goal_veloce_provider/goal_veloce_provider.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

class GoalVeloceHandler {
  Future saveAllGoalVeloce(BuildContext context) async {
    var goalVeloceProvider =
        Provider.of<GoalVeloceProvider>(context, listen: false);
    GoalVeloceRequests goalVeloceRequests = GoalVeloceRequests();

    Map<String, String> params = {};

    http.Response goalVeloceResponse =
        await goalVeloceRequests.getGoalVeloceList(params);

    if (goalVeloceResponse.statusCode == 200) {
      GoalVeloceModel goalVeloceModel =
          GoalVeloceModel.fromJson(json.decode(goalVeloceResponse.body));

      goalVeloceProvider
          .updateGoalVeloce(goalVeloceModel.goalVeloce?.firstOrNull);
    }
  }

  Future saveAllGoalVeloceBet(BuildContext context) async {
    var goalVeloceProvider =
        Provider.of<GoalVeloceProvider>(context, listen: false);
    GoalVeloceRequests goalVeloceRequests = GoalVeloceRequests();

    Map<String, String> params = {};

    http.Response goalVeloceBetResponse =
        await goalVeloceRequests.getGoalVeloceBetList(params);

    if (goalVeloceBetResponse.statusCode == 200) {
      GoalVeloceBetModel goalVeloceBetModel =
          GoalVeloceBetModel.fromJson(json.decode(goalVeloceBetResponse.body));

      if (goalVeloceBetModel.goalVeloceBet?.firstOrNull != null) {
        goalVeloceProvider
            .updateGoalVeloceBet(goalVeloceBetModel.goalVeloceBet?.firstOrNull);
      } else {
        if (context.mounted) {
          LoginHandler loginHandler = LoginHandler();
          LoginModel? currentUser = loginHandler.getCurrentUser(context);
          GoalVeloceBet newBet = GoalVeloceBet(userId: currentUser?.id);
          goalVeloceProvider.updateGoalVeloceBet(newBet);
        }
      }
    }
  }

  String? getTeamDescFromId(BuildContext context, int? id) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    return teamsProvider.teamsList
        .where((element) => element.id == id)
        .firstOrNull
        ?.name;
  }

  editTeamBet(BuildContext context, GoalVeloceProvider provider) async {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    List<SelectionListItemModel>? listItems = teamsProvider.teamsList
        .map((e) => SelectionListItemModel(
            key: e.id.toString(), keyInfo1: e.iso, value: e.name))
        .toList();

    if (listItems.isNotEmpty) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectionListPage(
            title: 'Seleziona Squadra',
            showLeadingWidget: (element) => true,
            leadingWidget: (element) {
              return TeamsHandler.getTeamFlag(element.keyInfo1);
            },
            listOfItems: listItems,
            showScanButton: false,
          ),
        ),
      );
      Teams? selectedTeam = teamsProvider.teamsList
          .where((element) => element.id.toString() == result)
          .firstOrNull;
      if (selectedTeam != null) {
        //aggiorno solo se l'utente ha selezionato un valore
        provider.updateTeamOfGoalVeloceBet(selectedTeam.id);
      }
    }
  }

  ///
  Future<bool> checkMandatoryFieldsOfGoalVeloceBet(
      GoalVeloceProvider provider) async {
    GoalVeloceBet? currentGoalVeloceBet = provider.goalVeloceBet;

    int? missingTeam = currentGoalVeloceBet?.idTeam;

    if (missingTeam == null) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra.");
      return false;
    }

    return true;
  }

  verifyGoalVeloceBet(BuildContext context, GoalVeloceProvider provider) async {
    bool success = await checkMandatoryFieldsOfGoalVeloceBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveGoalVeloceBet(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveGoalVeloceBet(
      BuildContext context, GoalVeloceProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.goalVeloceBet == null) return false;

    //imposto id del risultato di riferimento
    provider.goalVeloceBet?.goalVeloceId = provider.goalVeloce?.id;

    httpProvider.updateLoadingState(true);

    GoalVeloceRequests goalVeloceRequests = GoalVeloceRequests();

    http.Response saveGoalVeloceBetResponse;

    if (provider.goalVeloceBet?.id == null) {
      //inserimento
      saveGoalVeloceBetResponse =
          await goalVeloceRequests.insertGoalVeloceBet(provider.goalVeloceBet!);
    } else {
      //modifica
      saveGoalVeloceBetResponse =
          await goalVeloceRequests.editGoalVeloceBet(provider.goalVeloceBet!);
    }

    httpProvider.updateLoadingState(false);
    if (saveGoalVeloceBetResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllGoalVeloceBet(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  /// risultato effetitvo
  editTeam(BuildContext context, GoalVeloceProvider provider) async {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    List<SelectionListItemModel>? listItems = teamsProvider.teamsList
        .map((e) => SelectionListItemModel(
            key: e.id.toString(), keyInfo1: e.iso, value: e.name))
        .toList();

    if (listItems.isNotEmpty) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectionListPage(
            title: 'Seleziona Squadra',
            showLeadingWidget: (element) => true,
            leadingWidget: (element) {
              return TeamsHandler.getTeamFlag(element.keyInfo1);
            },
            listOfItems: listItems,
            showScanButton: false,
          ),
        ),
      );
      Teams? selectedTeam = teamsProvider.teamsList
          .where((element) => element.id.toString() == result)
          .firstOrNull;
      if (selectedTeam != null) {
        //aggiorno solo se l'utente ha selezionato un valore
        provider.updateTeamOfGoalVeloce(selectedTeam.id);
      }
    }
  }

  Future<bool> checkMandatoryFieldsOfGoalVeloce(
      GoalVeloceProvider provider) async {
    GoalVeloce? currentGoalVeloce = provider.goalVeloce;

    int? missingTeam = currentGoalVeloce?.idTeam;

    if (missingTeam == null) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra.");
      return false;
    }

    return true;
  }

  verifyGoalVeloce(BuildContext context, GoalVeloceProvider provider) async {
    bool success = await checkMandatoryFieldsOfGoalVeloce(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveGoalVeloce(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveGoalVeloce(
      BuildContext context, GoalVeloceProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.goalVeloce == null) return false;

    httpProvider.updateLoadingState(true);

    GoalVeloceRequests goalVeloceRequests = GoalVeloceRequests();

    http.Response saveGoalVeloceResponse =
        await goalVeloceRequests.editGoalVeloce(provider.goalVeloce!);

    httpProvider.updateLoadingState(false);
    if (saveGoalVeloceResponse.statusCode == 200) {
      //ricarico lista goal veloci
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllGoalVeloce(context);
      }
      if (context.mounted) {
        await saveAllGoalVeloceBet(context);
      }
      if (context.mounted) {
        PointsHandler pointsHandler = PointsHandler();
        await pointsHandler.saveAllPoints(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }
}
