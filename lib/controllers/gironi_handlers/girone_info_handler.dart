import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/gironi_handlers/gironi_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

class GironeInfoHandler {
  String? getTeamDescFromId(BuildContext context, int? id) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);

    return teamsProvider.teamsList
        .where((element) => element.id == id)
        .firstOrNull
        ?.name;
  }

  editTeam1(BuildContext context, GironiProvider provider) async {
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
        provider.updateTeam1OfSelectedGirone(selectedTeam.id);
      }
    }
  }

  editTeam2(BuildContext context, GironiProvider provider) async {
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
        provider.updateTeam2OfSelectedGirone(selectedTeam.id);
      }
    }
  }

  editTeam3(BuildContext context, GironiProvider provider) async {
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
        provider.updateTeam3OfSelectedGirone(selectedTeam.id);
      }
    }
  }

  editTeam4(BuildContext context, GironiProvider provider) async {
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
        provider.updateTeam4OfSelectedGirone(selectedTeam.id);
      }
    }
  }

  ///
  Future<bool> checkMandatoryFieldsOfGirone(GironiProvider provider) async {
    Gironi? currentGirone = provider.selectedGirone;

    bool missingTeam1 = currentGirone?.idTeam1 == null;
    bool missingTeam2 = currentGirone?.idTeam2 == null;
    bool missingTeam3 = currentGirone?.idTeam3 == null;
    bool missingTeam4 = currentGirone?.idTeam4 == null;

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

    if (missingTeam3) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra 3.");
      return false;
    }

    if (missingTeam4) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una squadra 4.");
      return false;
    }

    return true;
  }

  verifyGirone(BuildContext context, GironiProvider provider) async {
    bool success = await checkMandatoryFieldsOfGirone(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      GironiHandler gironiHandler = GironiHandler();
      bool saved = await gironiHandler.saveGirone(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
