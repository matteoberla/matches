import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/main.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';

class MatchesCallback {
  onMatchTileTap(BuildContext context, MatchesProvider provider, Matches match,
      MatchesBet? matchBet) async {
    MatchesHandler matchesHandler = MatchesHandler();
    //inizializzazione campi testo
    await matchesHandler.showBetBottomSheet(context, provider, match, matchBet);
  }

  onMatchTileLongPress(
    BuildContext context,
    MatchesProvider provider,
    Matches match,
  ) async {
    LoginHandler loginHandler = LoginHandler();
    if (loginHandler.currentUserIsAdminOrImpersona(context) == false) return;
    await Alerts.showConfirmAlertNoContext("Conferma", "Eliminare la partita?",
        () async {
      //eliminazione
      Navigator.of(navigatorKey.currentContext!).pop();
      MatchesHandler matchesHandler = MatchesHandler();
      await matchesHandler.deleteMatch(context, provider, match);
    }, () {
      Navigator.pop(context);
    });
  }

  onMatchBetGoalTeam1Changed(MatchesProvider provider, String newText) {
    MatchesHandler matchesHandler = MatchesHandler();
    matchesHandler.calcPronosticoOfSelectedMatchBet(provider);
  }

  onMatchBetGoalTeam2Changed(MatchesProvider provider, String newText) {
    MatchesHandler matchesHandler = MatchesHandler();
    matchesHandler.calcPronosticoOfSelectedMatchBet(provider);
  }

  onMatchGoalTeam1Changed(MatchesProvider provider, String newText) {
    MatchesHandler matchesHandler = MatchesHandler();
    matchesHandler.calcPronosticoOfSelectedMatch(provider);
  }

  onMatchGoalTeam2Changed(MatchesProvider provider, String newText) {
    MatchesHandler matchesHandler = MatchesHandler();
    matchesHandler.calcPronosticoOfSelectedMatch(provider);
  }

  onMatchBetSaved(BuildContext context, MatchesProvider provider) async {
    //check data scadenza
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      MatchesHandler matchesHandler = MatchesHandler();
      await matchesHandler.verifyMatchBet(context, provider);
    }
  }

  onMatchSaved(BuildContext context, MatchesProvider provider) async {
    MatchesHandler matchesHandler = MatchesHandler();
    await matchesHandler.verifyMatch(context, provider);
  }

  onImpostaRisultatoPressed(
      BuildContext context, MatchesProvider provider, Matches match) async {
    MatchesHandler matchesHandler = MatchesHandler();
    await matchesHandler.showMatchBottomSheet(context, provider, match);
  }

  onAddMatch(BuildContext context, MatchesProvider provider) {
    DateTime now = DateTime.now();

    Matches newMatch = Matches(date: now.toString(), fase: 1);
    provider.updateSelectedMatch(newMatch);
    //
    Navigator.pushNamed(context, '/match_info');
  }
}
