import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/fasi_provider/fasi_provider.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

class MatchInfoHandler {
  editFase(BuildContext context, MatchesProvider provider) async {
    var fasiProvider = Provider.of<FasiProvider>(context, listen: false);

    List<SelectionListItemModel>? listItems = fasiProvider.fasiList
        .map((e) => SelectionListItemModel(key: e.id.toString(), value: e.fase))
        .toList();

    if (listItems.isNotEmpty) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectionListPage(
            title: 'Seleziona Fase',
            listOfItems: listItems,
            showScanButton: false,
          ),
        ),
      );
      Fasi? selecteFase = fasiProvider.fasiList
          .where((element) => element.id.toString() == result)
          .firstOrNull;
      if (selecteFase != null) {
        //aggiorno solo se l'utente ha selezionato un valore
        provider.updateFaseOfSelectedMatch(selecteFase.id);
      }
    }
  }

  String? getFaseDescFromId(BuildContext context, int? id) {
    var fasiProvider = Provider.of<FasiProvider>(context, listen: false);

    return fasiProvider.fasiList
        .where((element) => element.id == id)
        .firstOrNull
        ?.fase;
  }

  String? getTeamDescFromId(BuildContext context, int? id) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    return teamsProvider.teamsList
        .where((element) => element.id == id)
        .firstOrNull
        ?.name;
  }

  editTeam1(BuildContext context, MatchesProvider provider) async {
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

  editTeam2(BuildContext context, MatchesProvider provider) async {
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

  ///
  Future<bool> checkMandatoryFieldsOfMatch(MatchesProvider provider) async {
    Matches? currentMatchBet = provider.selectedMatch;

    bool missingData = currentMatchBet?.date == null;
    bool missingFase = currentMatchBet?.fase == null;
    bool missingTeam1 = currentMatchBet?.idTeam1 == null;
    bool missingTeam2 = currentMatchBet?.idTeam2 == null;

    if (missingData) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare una data.");
      return false;
    }

    if (missingFase) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare una fase.");
      return false;
    }

    if (missingTeam1) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra 1.");
      return false;
    }

    if (missingTeam2) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra 2.");
      return false;
    }

    return true;
  }

  verifyMatch(BuildContext context, MatchesProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatch(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      MatchesHandler matchesHandler = MatchesHandler();
      bool saved = await matchesHandler.saveMatch(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
