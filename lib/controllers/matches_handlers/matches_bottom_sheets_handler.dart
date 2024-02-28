import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/matches_components/match_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_callback.dart';
import 'package:matches/controllers/text_controller_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class MatchesBottomSheetsHandler {
  showBetBottomSheet(BuildContext context, MatchesProvider provider) async {
    MatchesCallback matchesCallback = MatchesCallback();
    Matches? selectedMatch = provider.selectedMatch;
    if (selectedMatch == null) {
      return;
    }
    LoginHandler loginHandler = LoginHandler();
    MatchesBet? selectedMatchBet = provider.selectedMatchBet;
    if (selectedMatchBet == null) {
      LoginModel? currentUser = loginHandler.getCurrentUser(context);
      //nuova scommessa
      MatchesBet newMatchBet =
          MatchesBet(userId: currentUser?.id, matchId: selectedMatch.id);
      provider.updateSelectedMatchBet(newMatchBet);
      selectedMatchBet = provider.selectedMatchBet;
    }

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (matchBetContext) {
        var matchesProvider =
            Provider.of<MatchesProvider>(matchBetContext, listen: true);

        return Padding(
          padding: EdgeInsets.only(
              top: AppBar().preferredSize.height, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Scaffold(
              body: PalladioBody(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible:
                              loginHandler.currentUserIsAdmin(matchBetContext),
                          child: Row(
                            children: [
                              PalladioActionButton(
                                  title: "Imposta risultato",
                                  onTap: () async {
                                    Navigator.of(matchBetContext).pop();
                                    await matchesCallback
                                        .onImpostaRisultatoPressed(context,
                                            matchesProvider, selectedMatch);
                                  },
                                  backgroundColor: interactiveColor),
                            ],
                          ),
                        ),
                        MatchTile(
                          match: selectedMatch,
                          activeActions: false,
                        ),
                        const PalladioText(
                          "Il tuo risultato",
                          type: PTextType.h1,
                          bold: true,
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioText(
                          "Pronostico: ${matchesProvider.selectedMatchBet?.result ?? "Nessuno"}",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: PalladioTextInput(
                                  textController:
                                      selectedMatchBet?.goal1Controller ??
                                          TextEditingController(),
                                  allowedChars: AllowedChars.integer,
                                  onChanged: (newText) {
                                    matchesCallback.onMatchBetGoalTeam1Changed(
                                        provider, newText);
                                  },
                                  onTap: () {
                                    TextControllerHandler.moveCursorToEnd(
                                        selectedMatchBet?.goal1Controller);
                                  },
                                ),
                              ),
                              const EmptySpace(
                                width: 10,
                              ),
                              const PalladioText(
                                ":",
                                type: PTextType.h2,
                                bold: true,
                              ),
                              const EmptySpace(
                                width: 10,
                              ),
                              Expanded(
                                child: PalladioTextInput(
                                  textController:
                                      selectedMatchBet?.goal2Controller ??
                                          TextEditingController(),
                                  allowedChars: AllowedChars.integer,
                                  textAlign: TextAlign.start,
                                  onChanged: (newText) {
                                    matchesCallback.onMatchBetGoalTeam2Changed(
                                        provider, newText);
                                  },
                                  onTap: () {
                                    TextControllerHandler.moveCursorToEnd(
                                        selectedMatchBet?.goal2Controller);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(matchBetContext).pop();
                          },
                          onSave: () async {
                            await matchesCallback.onMatchBetSaved(
                                matchBetContext, provider);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showMatchBottomSheet(BuildContext context, MatchesProvider provider) async {
    MatchesCallback matchesCallback = MatchesCallback();
    Matches? selectedMatch = provider.selectedMatch;
    if (selectedMatch == null) {
      return;
    }

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (matchBetContext) {
        var matchesProvider =
            Provider.of<MatchesProvider>(matchBetContext, listen: true);

        return Padding(
          padding: EdgeInsets.only(
              top: AppBar().preferredSize.height, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Scaffold(
              body: PalladioBody(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MatchTile(
                          match: selectedMatch,
                          activeActions: false,
                        ),
                        const PalladioText(
                          "Risultato finale",
                          type: PTextType.h1,
                          bold: true,
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioText(
                          "Esito: ${matchesProvider.selectedMatch?.result ?? "Nessuno"}",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: PalladioTextInput(
                                  textController: selectedMatch.goal1Controller,
                                  allowedChars: AllowedChars.integer,
                                  onChanged: (newText) {
                                    matchesCallback.onMatchGoalTeam1Changed(
                                        provider, newText);
                                  },
                                  onTap: () {
                                    TextControllerHandler.moveCursorToEnd(
                                        selectedMatch.goal1Controller);
                                  },
                                ),
                              ),
                              const EmptySpace(
                                width: 10,
                              ),
                              const PalladioText(
                                ":",
                                type: PTextType.h2,
                                bold: true,
                              ),
                              const EmptySpace(
                                width: 10,
                              ),
                              Expanded(
                                child: PalladioTextInput(
                                  textController: selectedMatch.goal2Controller,
                                  allowedChars: AllowedChars.integer,
                                  textAlign: TextAlign.start,
                                  onChanged: (newText) {
                                    matchesCallback.onMatchGoalTeam2Changed(
                                        provider, newText);
                                  },
                                  onTap: () {
                                    TextControllerHandler.moveCursorToEnd(
                                        selectedMatch.goal2Controller);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(matchBetContext).pop();
                          },
                          onSave: () async {
                            await matchesCallback.onMatchSaved(
                                matchBetContext, provider);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
