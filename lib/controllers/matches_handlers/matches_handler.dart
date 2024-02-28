import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/matches_handlers/matches_bottom_sheets_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_requests.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

class MatchesHandler {
  Future saveAllMatches(BuildContext context) async {
    var matchesProvider = Provider.of<MatchesProvider>(context, listen: false);
    MatchesRequests matchesRequests = MatchesRequests();

    Map<String, String> params = {};

    http.Response matchesResponse =
        await matchesRequests.getMatchesList(params);

    if (matchesResponse.statusCode == 200) {
      MatchesModel matchesModel =
          MatchesModel.fromJson(json.decode(matchesResponse.body));
      matchesProvider.overrideMatchesList(matchesModel.matches ?? []);
    }
  }

  Future saveAllMatchesBet(BuildContext context) async {
    var matchesProvider = Provider.of<MatchesProvider>(context, listen: false);
    MatchesRequests matchesRequests = MatchesRequests();

    Map<String, String> params = {};

    http.Response matchesBetResponse =
        await matchesRequests.getMatchesBetList(params);

    if (matchesBetResponse.statusCode == 200) {
      MatchesBetModel matchesBetModel =
          MatchesBetModel.fromJson(json.decode(matchesBetResponse.body));
      matchesProvider.overrideMatchesBetList(matchesBetModel.matchesBet ?? []);
    }
  }

  MatchesBet? getMatchBetByMatchId(MatchesProvider provider, int? matchId) {
    return provider.matchesBetList
        .where((element) => element.matchId == matchId)
        .firstOrNull;
  }

  showBetBottomSheet(BuildContext context, MatchesProvider provider,
      Matches match, MatchesBet? matchBet) async {
    provider.updateSelectedMatch(match);
    //
    initializeAllMatchBetValues(provider, matchBet);
    provider.updateSelectedMatchBet(matchBet);

    MatchesBottomSheetsHandler matchesBottomSheetsHandler =
        MatchesBottomSheetsHandler();
    await matchesBottomSheetsHandler.showBetBottomSheet(context, provider);
  }

  initializeAllMatchBetValues(
      MatchesProvider provider, MatchesBet? matchesBet) {
    matchesBet?.goal1Controller.text =
        matchesBet.goalTeam1 != null ? matchesBet.goalTeam1.toString() : "";
    matchesBet?.goal2Controller.text =
        matchesBet.goalTeam2 != null ? matchesBet.goalTeam2.toString() : "";
    calcPronosticoOfSelectedMatchBet(provider);
  }

  showMatchBottomSheet(
      BuildContext context, MatchesProvider provider, Matches match) async {
    initializeAllMatchValues(provider, match);
    provider.updateSelectedMatch(match);

    MatchesBottomSheetsHandler matchesBottomSheetsHandler =
        MatchesBottomSheetsHandler();
    await matchesBottomSheetsHandler.showMatchBottomSheet(context, provider);
  }

  initializeAllMatchValues(MatchesProvider provider, Matches match) {
    match.goal1Controller.text =
        match.goalTeam1 != null ? match.goalTeam1.toString() : "";
    match.goal2Controller.text =
        match.goalTeam2 != null ? match.goalTeam2.toString() : "";
    calcPronosticoOfSelectedMatch(provider);
  }

  calcPronosticoOfSelectedMatchBet(
    MatchesProvider provider,
  ) {
    int? goalTeam1 =
        int.tryParse(provider.selectedMatchBet?.goal1Controller.text ?? "");
    int? goalTeam2 =
        int.tryParse(provider.selectedMatchBet?.goal2Controller.text ?? "");

    if (goalTeam1 != null && goalTeam2 != null) {
      if (goalTeam1 > goalTeam2) {
        return provider.updateResultOfSelectedMatchBet("1");
      } else if (goalTeam1 < goalTeam2) {
        return provider.updateResultOfSelectedMatchBet("2");
      } else {
        return provider.updateResultOfSelectedMatchBet("X");
      }
    } else {
      return provider.updateResultOfSelectedMatchBet(null);
    }
  }

  calcPronosticoOfSelectedMatch(
    MatchesProvider provider,
  ) {
    int? goalTeam1 =
        int.tryParse(provider.selectedMatch?.goal1Controller.text ?? "");
    int? goalTeam2 =
        int.tryParse(provider.selectedMatch?.goal2Controller.text ?? "");

    if (goalTeam1 != null && goalTeam2 != null) {
      if (goalTeam1 > goalTeam2) {
        return provider.updateResultOfSelectedMatch("1");
      } else if (goalTeam1 < goalTeam2) {
        return provider.updateResultOfSelectedMatch("2");
      } else {
        return provider.updateResultOfSelectedMatch("X");
      }
    } else {
      return provider.updateResultOfSelectedMatch(null);
    }
  }

  String getMatchGroup(BuildContext context, Matches match) {
    TeamsHandler teamsHandler = TeamsHandler();
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    Teams? team1 = teamsHandler.getTeamById(teamsProvider, match.idTeam1);

    return "Girone ${team1?.girone}";
  }

  ///match bet
  Future<bool> checkMandatoryFieldsOfMatchBet(MatchesProvider provider) async {
    MatchesBet? currentMatchBet = provider.selectedMatchBet;

    bool missingGoal1 = currentMatchBet?.goal1Controller.text == "";
    bool missingGoal2 = currentMatchBet?.goal2Controller.text == "";

    if (missingGoal1) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare i goal della squadra 1.");
      return false;
    }

    if (missingGoal2) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare i goal della squadra 2.");
      return false;
    }

    return true;
  }

  verifyMatchBet(BuildContext context, MatchesProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatchBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveMatchBet(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveMatchBet(
      BuildContext context, MatchesProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedMatchBet == null) return false;

    httpProvider.updateLoadingState(true);

    MatchesRequests matchesRequests = MatchesRequests();

    http.Response saveMatchBetResponse;

    provider.selectedMatchBet?.goalTeam1 =
        int.tryParse(provider.selectedMatchBet?.goal1Controller.text ?? "");
    provider.selectedMatchBet?.goalTeam2 =
        int.tryParse(provider.selectedMatchBet?.goal2Controller.text ?? "");

    if (provider.selectedMatchBet?.id == null) {
      //inserimento
      saveMatchBetResponse =
          await matchesRequests.insertMatchBet(provider.selectedMatchBet!);
    } else {
      //modifica
      saveMatchBetResponse =
          await matchesRequests.editMatchBet(provider.selectedMatchBet!);
    }

    httpProvider.updateLoadingState(false);
    if (saveMatchBetResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllMatchesBet(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  ///match
  Future<bool> checkMandatoryFieldsOfMatch(MatchesProvider provider) async {
    Matches? currentMatchBet = provider.selectedMatch;

    bool missingGoal1 = currentMatchBet?.goal1Controller.text == "";
    bool missingGoal2 = currentMatchBet?.goal2Controller.text == "";

    if (missingGoal1) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare i goal della squadra 1.");
      return false;
    }

    if (missingGoal2) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare i goal della squadra 2.");
      return false;
    }

    return true;
  }

  verifyMatch(BuildContext context, MatchesProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatch(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveMatch(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveMatch(BuildContext context, MatchesProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedMatch == null) return false;

    httpProvider.updateLoadingState(true);

    MatchesRequests matchesRequests = MatchesRequests();

    http.Response saveMatchResponse;

    provider.selectedMatch?.goalTeam1 =
        int.tryParse(provider.selectedMatch?.goal1Controller.text ?? "");
    provider.selectedMatch?.goalTeam2 =
        int.tryParse(provider.selectedMatch?.goal2Controller.text ?? "");

    if (provider.selectedMatch?.id == null) {
      //inserimento
      saveMatchResponse =
          await matchesRequests.insertMatch(provider.selectedMatch!);
    } else {
      //modifica
      saveMatchResponse =
          await matchesRequests.editMatch(provider.selectedMatch!);
    }

    httpProvider.updateLoadingState(false);
    if (saveMatchResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllMatches(context);
      }
      if (context.mounted) {
        await saveAllMatchesBet(context);
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

  ///
  Future<bool> deleteMatch(
      BuildContext context, MatchesProvider provider, Matches match) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    MatchesRequests matchesRequests = MatchesRequests();

    http.Response deleteMatchResponse;

    deleteMatchResponse = await matchesRequests.deleteMatch(match);

    httpProvider.updateLoadingState(false);
    if (deleteMatchResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllMatches(context);
      }

      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }
}
