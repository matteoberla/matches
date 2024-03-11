import 'package:flutter/material.dart';
import 'package:matches/controllers/capo_azz_handlers/capo_azz_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/models/capo_azz_models/capo_azz_bet_model.dart';
import 'package:matches/state_management/capo_azz_provider/capo_azz_provider.dart';

class CapoAzzCallback {
  onSavePressed(BuildContext context, CapoAzzProvider provider) async {
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      CapoAzzHandler capoAzzHandler = CapoAzzHandler();
      await capoAzzHandler.verifyCapoAzzBet(context, provider);
    }
  }

  onImpostaRisultatoPressed(CapoAzzProvider provider) {
    provider.toggleShowUsersBetList();
  }

  onBetValidityChanged(BuildContext context, CapoAzzProvider provider,
      CapoAzzBet capoAzzBet) async {
    if (capoAzzBet.isValid == 1) {
      capoAzzBet.isValid = 0;
    } else {
      capoAzzBet.isValid = 1;
    }
    CapoAzzHandler capoAzzHandler = CapoAzzHandler();
    await capoAzzHandler.updateUserCapoAzzBet(context, provider, capoAzzBet);
  }
}
