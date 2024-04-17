import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/team_rivelaz_handlers/team_rivelaz_requests.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_bet_model.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/team_rivelaz_provider/team_rivelaz_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

class TeamRivelazHandler {
  Future saveAllTeamRivelaz(BuildContext context) async {
    var teamRivelazProvider =
        Provider.of<TeamRivelazProvider>(context, listen: false);
    TeamRivelazRequests teamRivelazRequests = TeamRivelazRequests();

    Map<String, String> params = {};

    http.Response goalVeloceResponse =
        await teamRivelazRequests.getTeamRivelazList(params);

    if (goalVeloceResponse.statusCode == 200) {
      TeamRivelazModel teamRivelazModel =
          TeamRivelazModel.fromJson(json.decode(goalVeloceResponse.body));

      teamRivelazProvider
          .updateTeamRivelaz(teamRivelazModel.teamRivelaz?.firstOrNull);
    }
  }

  Future saveAllTeamRivelazBet(BuildContext context) async {
    var teamRivelazProvider =
        Provider.of<TeamRivelazProvider>(context, listen: false);
    TeamRivelazRequests teamRivelazRequests = TeamRivelazRequests();

    Map<String, String> params = {};

    http.Response teamRivelazBetResponse =
        await teamRivelazRequests.getTeamRivelazBetList(params);

    if (teamRivelazBetResponse.statusCode == 200) {
      TeamRivelazBetModel teamRivelazBetModel = TeamRivelazBetModel.fromJson(
          json.decode(teamRivelazBetResponse.body));

      if (teamRivelazBetModel.teamRivelazBet?.firstOrNull != null) {
        teamRivelazProvider.updateTeamRivelazBet(
            teamRivelazBetModel.teamRivelazBet?.firstOrNull);
      } else {
        if (context.mounted) {
          LoginHandler loginHandler = LoginHandler();
          LoginModel? currentUser = loginHandler.getCurrentUser(context);
          TeamRivelazBet newBet = TeamRivelazBet(userId: currentUser?.id);
          teamRivelazProvider.updateTeamRivelazBet(newBet);
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

  editTeamBet(BuildContext context, TeamRivelazProvider provider) async {
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
        provider.updateTeamOfTeamRivelazBet(selectedTeam.id);
      }
    }
  }

  ///
  Future<bool> checkMandatoryFieldsOfTeamRivelazBet(
      TeamRivelazProvider provider) async {
    TeamRivelazBet? currentTeamRivelazBet = provider.teamRivelazBet;

    int? missingTeam = currentTeamRivelazBet?.idTeam;

    if (missingTeam == null) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra.");
      return false;
    }

    return true;
  }

  verifyTeamRivelazBet(
      BuildContext context, TeamRivelazProvider provider) async {
    bool success = await checkMandatoryFieldsOfTeamRivelazBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveTeamRivelazBet(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveTeamRivelazBet(
      BuildContext context, TeamRivelazProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.teamRivelazBet == null) return false;

    //imposto id del risultato di riferimento
    provider.teamRivelazBet?.teamRivelazId = provider.teamRivelaz?.id;

    httpProvider.updateLoadingState(true);

    TeamRivelazRequests teamRivelazRequests = TeamRivelazRequests();

    http.Response saveTeamRivelazBetResponse;

    if (provider.teamRivelazBet?.id == null) {
      //inserimento
      saveTeamRivelazBetResponse = await teamRivelazRequests
          .insertTeamRivelazBet(provider.teamRivelazBet!);
    } else {
      //modifica
      saveTeamRivelazBetResponse = await teamRivelazRequests
          .editTeamRivelazBet(provider.teamRivelazBet!);
    }

    httpProvider.updateLoadingState(false);
    if (saveTeamRivelazBetResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllTeamRivelazBet(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  /// risultato effetitvo
  editTeam(BuildContext context, TeamRivelazProvider provider) async {
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
        provider.updateTeamOfTeamRivelaz(selectedTeam.id);
      }
    }
  }

  Future<bool> checkMandatoryFieldsOfTeamRivelaz(
      TeamRivelazProvider provider) async {
    TeamRivelaz? currentTeamRivelaz = provider.teamRivelaz;

    int? missingTeam = currentTeamRivelaz?.idTeam;

    if (missingTeam == null) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra.");
      return false;
    }

    return true;
  }

  verifyTeamRivelaz(BuildContext context, TeamRivelazProvider provider) async {
    bool success = await checkMandatoryFieldsOfTeamRivelaz(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveTeamRivelaz(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveTeamRivelaz(
      BuildContext context, TeamRivelazProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.teamRivelaz == null) return false;

    httpProvider.updateLoadingState(true);

    TeamRivelazRequests teamRivelazRequests = TeamRivelazRequests();

    http.Response saveTeamRivelazResponse =
        await teamRivelazRequests.editTeamRivelaz(provider.teamRivelaz!);

    httpProvider.updateLoadingState(false);
    if (saveTeamRivelazResponse.statusCode == 200) {
      //ricarico lista team rivelaz
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllTeamRivelaz(context);
      }
      if (context.mounted) {
        await saveAllTeamRivelazBet(context);
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
