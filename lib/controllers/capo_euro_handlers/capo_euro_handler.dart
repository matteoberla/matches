import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/capo_euro_handlers/capo_euro_requests.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/models/capo_euro_models/capo_euro_bet_model.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/state_management/capo_euro_provider/capo_euro_provider.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:provider/provider.dart';

class CapoEuroHandler {
  Future saveUsersCapoEuroBet(BuildContext context) async {
    var capoEuroProvider =
        Provider.of<CapoEuroProvider>(context, listen: false);
    CapoEuroRequests capoEuroRequests = CapoEuroRequests();

    Map<String, String> params = {};

    http.Response capoEuroResponse =
        await capoEuroRequests.getCapoEuroBetList(params, "0");

    if (capoEuroResponse.statusCode == 200) {
      CapoEuroBetModel capoEuroBetModel =
          CapoEuroBetModel.fromJson(json.decode(capoEuroResponse.body));
      capoEuroProvider
          .overrideUsersCapoEuroBetList(capoEuroBetModel.capoEuroBet ?? []);
    }
  }

  Future saveAllCapoEuroBet(BuildContext context) async {
    var capoEuroProvider =
        Provider.of<CapoEuroProvider>(context, listen: false);
    CapoEuroRequests capoEuroRequests = CapoEuroRequests();

    Map<String, String> params = {};

    http.Response capoEuroResponse =
        await capoEuroRequests.getCapoEuroBetList(params, "");

    if (capoEuroResponse.statusCode == 200) {
      CapoEuroBetModel capoEuroBetModel =
          CapoEuroBetModel.fromJson(json.decode(capoEuroResponse.body));

      if (context.mounted &&
          capoEuroBetModel.capoEuroBet != null &&
          capoEuroBetModel.capoEuroBet?.length == 2) {
        capoEuroProvider.overrideCapoEuroBetList(capoEuroBetModel.capoEuroBet!);
        initCapoEuroTextFelds(context);
      } else {
        if (context.mounted) {
          LoginHandler loginHandler = LoginHandler();
          LoginModel? currentUser = loginHandler.getCurrentUser(context);
          //creo le scommesse
          CapoEuroBetModel newBetModel = CapoEuroBetModel(capoEuroBet: [
            CapoEuroBet(betNum: 1, userId: currentUser?.id, isValid: 0),
            CapoEuroBet(betNum: 2, userId: currentUser?.id, isValid: 0),
          ]);

          capoEuroProvider
              .overrideCapoEuroBetList(newBetModel.capoEuroBet ?? []);
        }
      }
    }
  }

  initCapoEuroTextFelds(BuildContext context) {
    var capoEuroProvider =
        Provider.of<CapoEuroProvider>(context, listen: false);
    //inizializzazione campi
    capoEuroProvider.capoEuroBetList?[0].betController.text =
        capoEuroProvider.capoEuroBetList?[0].value ?? "";
    capoEuroProvider.capoEuroBetList?[1].betController.text =
        capoEuroProvider.capoEuroBetList?[1].value ?? "";
  }

  ///
  Future<bool> checkMandatoryFieldsOfCapoEuroBet(
      CapoEuroProvider provider) async {
    List<CapoEuroBet>? currentCapoEuroList = provider.capoEuroBetList;

    if (currentCapoEuroList
            ?.where((element) => element.betController.text == "")
            .isNotEmpty ==
        true) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Compilare tutti i nomi per procedere.");
      return false;
    }

    return true;
  }

  verifyCapoEuroBet(BuildContext context, CapoEuroProvider provider) async {
    bool success = await checkMandatoryFieldsOfCapoEuroBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveCapoEuroBet(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveCapoEuroBet(
      BuildContext context, CapoEuroProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.capoEuroBetList == null) return false;

    httpProvider.updateLoadingState(true);
    //imposto valori dei textfield
    for (var bet in provider.capoEuroBetList!) {
      bet.value = bet.betController.text;

      bool success = await handleCapoEuroSave(context, bet);
      if (!success) return false;
    }
    httpProvider.updateLoadingState(false);

    httpProvider.updateLoadingState(true);
    //ricarico lista capo euro
    if (context.mounted) {
      await saveAllCapoEuroBet(context);
    }
    if (context.mounted) {
      PointsHandler pointsHandler = PointsHandler();
      await pointsHandler.saveAllPoints(context);
    }

    httpProvider.updateLoadingState(false);
    return true;
  }

  handleCapoEuroSave(BuildContext context, CapoEuroBet capoEuroBet) async {
    CapoEuroRequests capoEuroRequests = CapoEuroRequests();

    http.Response saveCapoEuroBetResponse;

    if (capoEuroBet.id == null) {
      //inserimento
      saveCapoEuroBetResponse =
          await capoEuroRequests.insertCapoEuroBet(capoEuroBet);
    } else {
      //modifica
      saveCapoEuroBetResponse =
          await capoEuroRequests.editCapoEuroBet(capoEuroBet);
    }

    if (saveCapoEuroBetResponse.statusCode == 200) {
      return true;
    }

    return false;
  }

  ///
  updateUserCapoEuroBet(BuildContext context, CapoEuroProvider provider,
      CapoEuroBet capoEuroBet) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.capoEuroBetList == null) return false;

    httpProvider.updateLoadingState(true);

    CapoEuroRequests capoEuroRequests = CapoEuroRequests();

    http.Response saveCapoEuroBetResponse =
        await capoEuroRequests.editCapoEuroBet(capoEuroBet);

    httpProvider.updateLoadingState(false);

    if (saveCapoEuroBetResponse.statusCode == 200) {
      httpProvider.updateLoadingState(true);
      //ricarico lista bet capo euro
      if (context.mounted) {
        await saveUsersCapoEuroBet(context);
      }
      if (context.mounted) {
        PointsHandler pointsHandler = PointsHandler();
        await pointsHandler.saveAllPoints(context);
      }

      httpProvider.updateLoadingState(false);
      return true;
    }
  }

  String? getUsernameFromUserId(BuildContext context, CapoEuroBet capoAzzBet) {
    var pointsProvider = Provider.of<PointsProvider>(context, listen: false);
    return pointsProvider.pointsList
        .where((element) => element.userId == capoAzzBet.userId)
        .firstOrNull
        ?.username;
  }
}
