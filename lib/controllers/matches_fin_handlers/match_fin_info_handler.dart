import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_handler.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/screens/selection_list.dart';
import 'package:matches/state_management/fasi_provider/fasi_provider.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:provider/provider.dart';

class MatchFinInfoHandler {
  editFase(BuildContext context, MatchesFinProvider provider) async {
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

  ///
  Future<bool> checkMandatoryFieldsOfMatch(MatchesFinProvider provider) async {
    Matches? currentMatchBet = provider.selectedMatch;

    bool missingData = currentMatchBet?.date == null;
    bool missingFase = currentMatchBet?.fase == null;
    bool missingDes1 = currentMatchBet?.des1Controller.text == "";
    bool missingDes2 = currentMatchBet?.des2Controller.text == "";
    bool missingNMatch =
        int.tryParse(currentMatchBet?.nMatchController.text ?? "") == null;

    if (missingData) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare una data.");
      return false;
    }

    if (missingFase) {
      await Alerts.showInfoAlertNoContext("Attenzione", "Indicare una fase.");
      return false;
    }

    if (missingDes1) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una descrizione per la squadra 1.");
      return false;
    }

    if (missingDes2) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare una descrizione per la squadra 2.");
      return false;
    }

    if (missingNMatch) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare un numero partita.");
      return false;
    }

    return true;
  }

  verifyMatch(BuildContext context, MatchesFinProvider provider) async {
    bool success = await checkMandatoryFieldsOfMatch(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      MatchesFinHandler matchesFinHandler = MatchesFinHandler();
      bool saved = await matchesFinHandler.saveMatch(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
