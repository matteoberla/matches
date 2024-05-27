import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/gironi_handlers/gironi_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/main.dart';
import 'package:matches/models/gironi_models/gironi_bet_model.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';

class GironiCallback {
  onAddGirone(BuildContext context, GironiProvider provider) {
    Gironi newGirone = Gironi();
    provider.updateSelectedGirone(newGirone);
    //
    Navigator.pushNamed(context, '/girone_info');
  }

  onGironeTileTap(BuildContext context, GironiProvider provider, Gironi girone,
      GironiBet? gironeBet) async {
    GironiHandler gironiHandler = GironiHandler();
    //inizializzazione campi testo
    await gironiHandler.showBetBottomSheet(
        context, provider, girone, gironeBet);
  }

  onGironeTileLongPress(
    BuildContext context,
    GironiProvider provider,
    Gironi girone,
  ) async {
    LoginHandler loginHandler = LoginHandler();
    if (loginHandler.currentUserIsAdminOrImpersona(context) == false) return;
    await Alerts.showConfirmAlertNoContext("Conferma", "Eliminare il girone?",
        () async {
      //eliminazione
      Navigator.of(navigatorKey.currentContext!).pop();
      GironiHandler gironiHandler = GironiHandler();
      await gironiHandler.deleteGirone(context, provider, girone);
    }, () {
      Navigator.pop(context);
    });
  }

  onGironeBetSaved(BuildContext context, GironiProvider provider) async {
    //check data scadenza
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      GironiHandler gironiHandler = GironiHandler();
      await gironiHandler.verifyGironeBet(context, provider);
    }
  }

  onGironeSaved(BuildContext context, GironiProvider provider) async {
    GironiHandler gironiHandler = GironiHandler();
    await gironiHandler.verifyGirone(context, provider);
  }

  onImpostaRisultatoPressed(
      BuildContext context, GironiProvider provider, Gironi girone) async {
    GironiHandler gironiHandler = GironiHandler();
    await gironiHandler.showGironeBottomSheet(context, provider, girone);
  }

  onCompilaGironePressed(BuildContext context, GironiProvider provider,
      Gironi girone, GironiBet? gironeBet) async {
    GironiHandler gironiHandler = GironiHandler();
    await gironiHandler.autocompilaGirone(context, provider, girone, gironeBet);
  }
}
