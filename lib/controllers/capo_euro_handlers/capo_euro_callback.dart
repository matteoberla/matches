import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/capo_euro_handlers/capo_euro_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/models/capo_euro_models/capo_euro_bet_model.dart';
import 'package:matches/state_management/capo_euro_provider/capo_euro_provider.dart';

class CapoEuroCallback {
  onSavePressed(BuildContext context, CapoEuroProvider provider) async {
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      CapoEuroHandler capoEuroHandler = CapoEuroHandler();
      await capoEuroHandler.verifyCapoEuroBet(context, provider);
    }
  }

  onImpostaRisultatoPressed(CapoEuroProvider provider) {
    provider.toggleShowUsersBetList();
  }

  onBetValidityChanged(BuildContext context, CapoEuroProvider provider,
      CapoEuroBet capoEuroBet) async {
    if (capoEuroBet.isValid == 1) {
      capoEuroBet.isValid = 0;
    } else {
      capoEuroBet.isValid = 1;
    }
    CapoEuroHandler capoEuroHandler = CapoEuroHandler();
    await capoEuroHandler.updateUserCapoEuroBet(context, provider, capoEuroBet);
  }
}
