import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/capo_azz_handlers/capo_azz_requests.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/models/capo_azz_models/capo_azz_bet_model.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/state_management/capo_azz_provider/capo_azz_provider.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';

class CapoAzzHandler {
  Future saveUsersCapoAzzBet(BuildContext context) async {
    var capoEuroProvider = Provider.of<CapoAzzProvider>(context, listen: false);
    CapoAzzRequests capoAzzRequests = CapoAzzRequests();

    Map<String, String> params = {};

    http.Response capoEuroResponse =
        await capoAzzRequests.getCapoAzzBetList(params, "0");

    if (capoEuroResponse.statusCode == 200) {
      CapoAzzBetModel capoAzzBetModel =
          CapoAzzBetModel.fromJson(json.decode(capoEuroResponse.body));
      capoEuroProvider
          .overrideUsersCapoAzzBetList(capoAzzBetModel.capoAzzBet ?? []);
    }
  }

  Future saveAllCapoAzzBet(BuildContext context) async {
    var capoEuroProvider = Provider.of<CapoAzzProvider>(context, listen: false);
    CapoAzzRequests capoAzzRequests = CapoAzzRequests();

    Map<String, String> params = {};

    http.Response capoEuroResponse =
        await capoAzzRequests.getCapoAzzBetList(params, "");

    if (capoEuroResponse.statusCode == 200) {
      CapoAzzBetModel capoAzzBetModel =
          CapoAzzBetModel.fromJson(json.decode(capoEuroResponse.body));

      if (context.mounted &&
          capoAzzBetModel.capoAzzBet != null &&
          capoAzzBetModel.capoAzzBet?.length == 2) {
        capoEuroProvider.overrideCapoAzzBetList(capoAzzBetModel.capoAzzBet!);
        initCapoAzzTextFelds(context);
      } else {
        if (context.mounted) {
          LoginHandler loginHandler = LoginHandler();
          LoginModel? currentUser = loginHandler.getCurrentUser(context);
          //creo le scommesse
          CapoAzzBetModel newBetModel = CapoAzzBetModel(capoAzzBet: [
            CapoAzzBet(betNum: 1, userId: currentUser?.id, isValid: 0),
            CapoAzzBet(betNum: 2, userId: currentUser?.id, isValid: 0),
          ]);

          capoEuroProvider.overrideCapoAzzBetList(newBetModel.capoAzzBet ?? []);
        }
      }
    }
  }

  initCapoAzzTextFelds(BuildContext context) {
    var capoAzzProvider = Provider.of<CapoAzzProvider>(context, listen: false);
    //inizializzazione campi
    capoAzzProvider.capoAzzBetList?[0].betController.text =
        capoAzzProvider.capoAzzBetList?[0].value ?? "";
    capoAzzProvider.capoAzzBetList?[1].betController.text =
        capoAzzProvider.capoAzzBetList?[1].value ?? "";
  }

  ///
  Future<bool> checkMandatoryFieldsOfCapoAzzBet(
      CapoAzzProvider provider) async {
    List<CapoAzzBet>? currentCapoAzzList = provider.capoAzzBetList;

    if (currentCapoAzzList
            ?.where((element) => element.betController.text == "")
            .isNotEmpty ==
        true) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Compilare tutti i nomi per procedere.");
      return false;
    }

    return true;
  }

  verifyCapoAzzBet(BuildContext context, CapoAzzProvider provider) async {
    bool success = await checkMandatoryFieldsOfCapoAzzBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveCapoAzzBet(context, provider);
      if (saved) {
        await Alerts.showInfoAlertNoContext(
            "Conferma", "Salvato con successo!");
      }
    }
  }

  Future<bool> saveCapoAzzBet(
      BuildContext context, CapoAzzProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.capoAzzBetList == null) return false;

    httpProvider.updateLoadingState(true);
    //imposto valori dei textfield
    for (var bet in provider.capoAzzBetList!) {
      bet.value = bet.betController.text;

      bool success = await handleCapoAzzSave(context, bet);
      if (!success) return false;
    }
    httpProvider.updateLoadingState(false);

    httpProvider.updateLoadingState(true);
    //ricarico lista capo euro
    if (context.mounted) {
      await saveAllCapoAzzBet(context);
    }
    if (context.mounted) {
      PointsHandler pointsHandler = PointsHandler();
      await pointsHandler.saveAllPoints(context);
    }

    httpProvider.updateLoadingState(false);
    return true;
  }

  handleCapoAzzSave(BuildContext context, CapoAzzBet capoEuroBet) async {
    CapoAzzRequests capoAzzRequests = CapoAzzRequests();

    http.Response saveCapoEuroBetResponse;

    if (capoEuroBet.id == null) {
      //inserimento
      saveCapoEuroBetResponse =
          await capoAzzRequests.insertCapoAzzBet(capoEuroBet);
    } else {
      //modifica
      saveCapoEuroBetResponse =
          await capoAzzRequests.editCapoAzzBet(capoEuroBet);
    }

    if (saveCapoEuroBetResponse.statusCode == 200) {
      return true;
    }

    return false;
  }

  ///
  updateUserCapoAzzBet(BuildContext context, CapoAzzProvider provider,
      CapoAzzBet capoEuroBet) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.capoAzzBetList == null) return false;

    httpProvider.updateLoadingState(true);

    CapoAzzRequests capoAzzoRequests = CapoAzzRequests();

    http.Response saveCapoAzzBetResponse =
        await capoAzzoRequests.editCapoAzzBet(capoEuroBet);

    httpProvider.updateLoadingState(false);

    if (saveCapoAzzBetResponse.statusCode == 200) {
      httpProvider.updateLoadingState(true);
      //ricarico lista bet capo euro
      if (context.mounted) {
        await saveUsersCapoAzzBet(context);
      }
      if (context.mounted) {
        PointsHandler pointsHandler = PointsHandler();
        await pointsHandler.saveAllPoints(context);
      }

      httpProvider.updateLoadingState(false);
      return true;
    }
  }
}
