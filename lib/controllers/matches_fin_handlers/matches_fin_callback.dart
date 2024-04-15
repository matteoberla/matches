import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_handler.dart';
import 'package:matches/main.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';

class MatchesFinCallback {
  onMatchTileTap(BuildContext context, MatchesFinProvider provider,
      Matches match, MatchesBet? matchBet) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    //inizializzazione campi testo
    await matchesFinHandler.showBetBottomSheet(
        context, provider, match, matchBet);
  }

  onMatchTileLongPress(
    BuildContext context,
    MatchesFinProvider provider,
    Matches match,
  ) async {
    LoginHandler loginHandler = LoginHandler();
    if (loginHandler.currentUserIsAdmin(context) == false) return;
    await Alerts.showConfirmAlertNoContext("Conferma", "Eliminare la partita?",
        () async {
      //eliminazione
      Navigator.of(navigatorKey.currentContext!).pop();
      MatchesFinHandler matchesFinHandler = MatchesFinHandler();
      await matchesFinHandler.deleteMatch(context, provider, match);
    }, () {
      Navigator.pop(context);
    });
  }

  onBetTeam1Pressed(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.editBetTeam1(context, provider);
  }

  onBetTeam2Pressed(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.editBetTeam2(context, provider);
  }

  onTeam1Pressed(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.editTeam1(context, provider);
  }

  onTeam2Pressed(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.editTeam2(context, provider);
  }

  onMatchBetGoalTeam1Changed(MatchesFinProvider provider, String newText) {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    matchesFinHandler.calcPronosticoOfSelectedMatchBet(provider);
  }

  onMatchBetGoalTeam2Changed(MatchesFinProvider provider, String newText) {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    matchesFinHandler.calcPronosticoOfSelectedMatchBet(provider);
  }

  onMatchGoalTeam1Changed(MatchesFinProvider provider, String newText) {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    matchesFinHandler.calcPronosticoOfSelectedMatch(provider);
  }

  onMatchGoalTeam2Changed(MatchesFinProvider provider, String newText) {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    matchesFinHandler.calcPronosticoOfSelectedMatch(provider);
  }

  onMatchBetFinalResultChanged(MatchesFinProvider provider, bool newState) {
    provider.updateFinalResultOfSelectedMatchBet(newState ? "2" : "1");
  }

  onMatchFinalResultChanged(MatchesFinProvider provider, bool newState) {
    provider.updateFinalResultOfSelectedMatch(newState ? "2" : "1");
  }

  onMatchBetSaved(BuildContext context, MatchesFinProvider provider) async {
    //check data scadenza
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      MatchesFinHandler matchesFinHandler = MatchesFinHandler();
      await matchesFinHandler.verifyMatchBet(context, provider);
    }
  }

  onMatchSaved(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.verifyMatch(context, provider);
  }

  onImpostaRisultatoPressed(
      BuildContext context, MatchesFinProvider provider, Matches match) async {
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    await matchesFinHandler.showMatchBottomSheet(context, provider, match);
  }

  onAddMatch(BuildContext context, MatchesFinProvider provider) {
    DateTime now = DateTime.now();

    Matches newMatch = Matches(date: now.toString(), fase: 2);
    provider.updateSelectedMatch(newMatch);
    //
    Navigator.pushNamed(context, '/match_fin_info');
  }
}
