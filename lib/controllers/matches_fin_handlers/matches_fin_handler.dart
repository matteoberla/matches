import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_bottom_sheets_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_requests.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class MatchesFinHandler {
  Future saveAllMatches(BuildContext context) async {
    var matchesProvider =
        Provider.of<MatchesFinProvider>(context, listen: false);
    MatchesFinRequests matchesFinRequests = MatchesFinRequests();

    Map<String, String> params = {};

    http.Response matchesResponse =
        await matchesFinRequests.getMatchesList(params);

    if (matchesResponse.statusCode == 200) {
      MatchesModel matchesModel =
          MatchesModel.fromJson(json.decode(matchesResponse.body));
      matchesProvider.overrideMatchesList(matchesModel.matches ?? []);
    }
  }

  Future saveAllMatchesBet(BuildContext context) async {
    var matchesFinProvider =
        Provider.of<MatchesFinProvider>(context, listen: false);
    MatchesFinRequests matchesFinRequests = MatchesFinRequests();

    Map<String, String> params = {};

    http.Response matchesBetResponse =
        await matchesFinRequests.getMatchesBetList(params);

    if (matchesBetResponse.statusCode == 200) {
      MatchesBetModel matchesBetModel =
          MatchesBetModel.fromJson(json.decode(matchesBetResponse.body));
      matchesFinProvider
          .overrideMatchesBetList(matchesBetModel.matchesBet ?? []);
    }
  }

  MatchesBet? getMatchBetByMatchId(MatchesFinProvider provider, int? matchId) {
    return provider.matchesBetList
        .where((element) => element.matchId == matchId)
        .firstOrNull;
  }

  showBetBottomSheet(BuildContext context, MatchesFinProvider provider,
      Matches match, MatchesBet? matchBet) async {
    provider.updateSelectedMatch(match);
    //
    initializeAllMatchBetValues(provider, matchBet);
    provider.updateSelectedMatchBet(matchBet);

    MatchesFinBottomSheetsHandler matchesFinBottomSheetsHandler =
        MatchesFinBottomSheetsHandler();
    await matchesFinBottomSheetsHandler.showBetBottomSheet(context, provider);
  }

  initializeAllMatchBetValues(
      MatchesFinProvider provider, MatchesBet? matchesBet) {
    matchesBet?.goal1Controller.text =
        matchesBet.goalTeam1 != null ? matchesBet.goalTeam1.toString() : "";
    matchesBet?.goal2Controller.text =
        matchesBet.goalTeam2 != null ? matchesBet.goalTeam2.toString() : "";
    calcPronosticoOfSelectedMatchBet(provider);
  }

  showMatchBottomSheet(
      BuildContext context, MatchesFinProvider provider, Matches match) async {
    initializeAllMatchValues(provider, match);
    provider.updateSelectedMatch(match);

    MatchesFinBottomSheetsHandler matchesFinBottomSheetsHandler =
        MatchesFinBottomSheetsHandler();
    await matchesFinBottomSheetsHandler.showMatchBottomSheet(context, provider);
  }

  initializeAllMatchValues(MatchesFinProvider provider, Matches match) {
    match.des1Controller.text = match.des1 ?? "";
    match.des2Controller.text = match.des2 ?? "";
    match.nMatchController.text =
        match.nMatch != null ? match.nMatch.toString() : "";
    match.goal1Controller.text =
        match.goalTeam1 != null ? match.goalTeam1.toString() : "";
    match.goal2Controller.text =
        match.goalTeam2 != null ? match.goalTeam2.toString() : "";
    calcPronosticoOfSelectedMatch(provider);
  }

  calcPronosticoOfSelectedMatchBet(
    MatchesFinProvider provider,
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
    MatchesFinProvider provider,
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

  ///
  ///
  Color getTileColor(Fasi? fase) {
    if (fase != null) {
      switch (fase.id) {
        case 2:
          //ottavi
          return Colors.white;
        case 3:
          //quarti
          return Colors.lightGreen[100]!;
        case 4:
          //semi
          return Colors.orange[100]!;
        case 5:
          //fin
          return Colors.yellow[100]!;
        default:
          backgroundColor;
      }
    }
    return backgroundColor;
  }

  String? getTeamDescFromId(BuildContext context, int? id) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    return teamsProvider.teamsList
        .where((element) => element.id == id)
        .firstOrNull
        ?.name;
  }

  editBetTeam1(BuildContext context, MatchesFinProvider provider) async {
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
        provider.updateTeam1OfSelectedMatchBet(selectedTeam.id);
      }
    }
  }

  editBetTeam2(BuildContext context, MatchesFinProvider provider) async {
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
        provider.updateTeam2OfSelectedMatchBet(selectedTeam.id);
      }
    }
  }

  editTeam1(BuildContext context, MatchesFinProvider provider) async {
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
        provider.updateTeam1OfSelectedMatch(selectedTeam.id);
      }
    }
  }

  editTeam2(BuildContext context, MatchesFinProvider provider) async {
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
        provider.updateTeam2OfSelectedMatch(selectedTeam.id);
      }
    }
  }

  ///match bet
  Future<bool> checkMandatoryFieldsOfMatchBet(
      MatchesFinProvider provider) async {
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

  verifyMatchBet(BuildContext context, MatchesFinProvider provider) async {
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
      BuildContext context, MatchesFinProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedMatchBet == null) return false;

    httpProvider.updateLoadingState(true);

    MatchesFinRequests matchesFinRequests = MatchesFinRequests();

    http.Response saveMatchBetResponse;

    provider.selectedMatchBet?.goalTeam1 =
        int.tryParse(provider.selectedMatchBet?.goal1Controller.text ?? "");
    provider.selectedMatchBet?.goalTeam2 =
        int.tryParse(provider.selectedMatchBet?.goal2Controller.text ?? "");

    if (provider.selectedMatchBet?.id == null) {
      //inserimento
      saveMatchBetResponse =
          await matchesFinRequests.insertMatchBet(provider.selectedMatchBet!);
    } else {
      //modifica
      saveMatchBetResponse =
          await matchesFinRequests.editMatchBet(provider.selectedMatchBet!);
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
  Future<bool> checkMandatoryFieldsOfMatch(MatchesFinProvider provider) async {
    Matches? currentMatchBet = provider.selectedMatch;

    bool missingTeam1 = currentMatchBet?.idTeam1 == null;
    bool missingTeam2 = currentMatchBet?.idTeam2 == null;
    bool missingGoal1 = currentMatchBet?.goal1Controller.text == "";
    bool missingGoal2 = currentMatchBet?.goal2Controller.text == "";

    if (missingTeam1) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare la squadra 1.");
      return false;
    }

    if (missingTeam2) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare la squadra 2.");
      return false;
    }

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

  verifyMatch(BuildContext context, MatchesFinProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatch(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveMatch(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveMatch(
      BuildContext context, MatchesFinProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedMatch == null) return false;

    httpProvider.updateLoadingState(true);

    MatchesFinRequests matchesFinRequests = MatchesFinRequests();

    http.Response saveMatchResponse;

    provider.selectedMatch?.des1 =
        provider.selectedMatch?.des1Controller.text ?? "";
    provider.selectedMatch?.des2 =
        provider.selectedMatch?.des2Controller.text ?? "";
    provider.selectedMatch?.nMatch =
        int.tryParse(provider.selectedMatch?.nMatchController.text ?? "");
    provider.selectedMatch?.goalTeam1 =
        int.tryParse(provider.selectedMatch?.goal1Controller.text ?? "");
    provider.selectedMatch?.goalTeam2 =
        int.tryParse(provider.selectedMatch?.goal2Controller.text ?? "");

    if (provider.selectedMatch?.id == null) {
      //inserimento
      saveMatchResponse =
          await matchesFinRequests.insertMatch(provider.selectedMatch!);
    } else {
      //modifica
      saveMatchResponse =
          await matchesFinRequests.editMatch(provider.selectedMatch!);
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
      BuildContext context, MatchesFinProvider provider, Matches match) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    MatchesFinRequests matchesFinRequests = MatchesFinRequests();

    http.Response deleteMatchResponse;

    deleteMatchResponse = await matchesFinRequests.deleteMatch(match);

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
