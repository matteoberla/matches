import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/teams_handlers/teams_requests.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class TeamsHandler {
  static Widget getTeamFlag(String? iso) {
    if (iso != null) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Image.network(
          'https://flagcdn.com/h40/${iso.toLowerCase()}.png',
          width: 60,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: foregroundColor),
            color: backgroundColor,
          ),
        ),
      );
    }
  }

  Future saveAllTeams(BuildContext context) async {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    TeamsRequests teamsRequests = TeamsRequests();

    Map<String, String> params = {};

    http.Response teamsResponse = await teamsRequests.getTeamsList(params);

    if (teamsResponse.statusCode == 200) {
      TeamsModel teamsModel =
          TeamsModel.fromJson(json.decode(teamsResponse.body));
      teamsProvider.overrideTeamsList(teamsModel.teams ?? []);
    }
  }

  Teams? getTeamById(TeamsProvider provider, int? id) {
    return provider.teamsList.where((element) => element.id == id).firstOrNull;
  }

  ///team
  Future<bool> checkMandatoryFieldsOfMatch(TeamsProvider provider) async {
    Teams? currentTeam = provider.selectedTeam;

    bool missingName = currentTeam?.nameController.text == "";
    bool missingIso = currentTeam?.isoController.text == "";
    bool missingGirone = currentTeam?.gironeController.text == "";

    if (missingName) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare nome.");
      return false;
    }

    if (missingIso) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare ISO.");
      return false;
    }

    if (missingGirone) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare girone.");
      return false;
    }

    return true;
  }

  verifyTeam(BuildContext context, TeamsProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatch(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveTeam(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveTeam(BuildContext context, TeamsProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedTeam == null) return false;

    httpProvider.updateLoadingState(true);

    TeamsRequests teamsRequests = TeamsRequests();

    http.Response saveTeamResponse;

    //inserisco dati
    provider.selectedTeam?.name =
        provider.selectedTeam?.nameController.text ?? "";
    provider.selectedTeam?.iso =
        provider.selectedTeam?.isoController.text ?? "";
    provider.selectedTeam?.girone =
        provider.selectedTeam?.gironeController.text ?? "";

    if (provider.selectedTeam?.id == null) {
      //inserimento
      saveTeamResponse = await teamsRequests.insertTeam(provider.selectedTeam!);
    } else {
      //modifica
      saveTeamResponse = await teamsRequests.editTeam(provider.selectedTeam!);
    }

    httpProvider.updateLoadingState(false);
    if (saveTeamResponse.statusCode == 200) {
      //ricarico lista
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllTeams(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  ///
  Future<bool> deleteTeam(
      BuildContext context, TeamsProvider provider, Teams team) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    TeamsRequests teamsRequests = TeamsRequests();

    http.Response deleteTeamResponse;

    deleteTeamResponse = await teamsRequests.deleteTeam(team);

    httpProvider.updateLoadingState(false);
    if (deleteTeamResponse.statusCode == 200) {
      //ricarico lista teams
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllTeams(context);
      }

      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }
}
