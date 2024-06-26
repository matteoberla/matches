import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/matches_components/match_fin_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_responsive_form_field.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_callback.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_handler.dart';
import 'package:matches/controllers/text_controller_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class MatchesFinBottomSheetsHandler {
  showBetBottomSheet(BuildContext context, MatchesFinProvider provider) async {
    MatchesFinCallback matchesFinCallback = MatchesFinCallback();
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
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
        var matchesFinProvider =
            Provider.of<MatchesFinProvider>(matchBetContext, listen: true);

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
                          visible: loginHandler
                              .currentUserIsAdminOrImpersona(matchBetContext),
                          child: Row(
                            children: [
                              PalladioActionButton(
                                  title: "Imposta risultato",
                                  onTap: () async {
                                    Navigator.of(matchBetContext).pop();
                                    await matchesFinCallback
                                        .onImpostaRisultatoPressed(context,
                                            matchesFinProvider, selectedMatch);
                                  },
                                  backgroundColor: interactiveColor),
                            ],
                          ),
                        ),
                        MatchFinTile(
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
                        ResponsiveRow(
                          columnsCount: 100,
                          children: [
                            PalladioResponsiveFormField(
                              fieldTitle: "Squadra 1",
                              formField: SizedBox(
                                width: double.infinity,
                                child: TypedActionButtonWidget(
                                  displayedValue:
                                      matchesFinHandler.getTeamDescFromId(
                                              context,
                                              selectedMatchBet?.idTeam1) ??
                                          "Nessuna selezione",
                                  onPressed: () async {
                                    await matchesFinCallback.onBetTeam1Pressed(
                                        context, matchesFinProvider);
                                  },
                                ),
                              ),
                            ),
                            PalladioResponsiveFormField(
                              fieldTitle: "Squadra 2",
                              formField: SizedBox(
                                width: double.infinity,
                                child: TypedActionButtonWidget(
                                  displayedValue:
                                      matchesFinHandler.getTeamDescFromId(
                                              context,
                                              selectedMatchBet?.idTeam2) ??
                                          "Nessuna selezione",
                                  onPressed: () async {
                                    await matchesFinCallback.onBetTeam2Pressed(
                                        context, matchesFinProvider);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioText(
                          "Pronostico: ${matchesFinProvider.selectedMatchBet?.result ?? "Nessuno"}",
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
                                    matchesFinCallback
                                        .onMatchBetGoalTeam1Changed(
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
                                    matchesFinCallback
                                        .onMatchBetGoalTeam2Changed(
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
                        if (matchesFinProvider.selectedMatchBet?.result == "X")
                          Column(
                            children: [
                              const PalladioText(
                                "Vincente",
                                type: PTextType.h2,
                                bold: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PalladioText(
                                    "Squadra 1",
                                    type: PTextType.h3,
                                    bold: matchesFinProvider
                                            .selectedMatchBet?.finalResult ==
                                        "1",
                                  ),
                                  Switch(
                                    value: matchesFinProvider
                                            .selectedMatchBet?.finalResult ==
                                        "2",
                                    onChanged: (newState) {
                                      matchesFinCallback
                                          .onMatchBetFinalResultChanged(
                                              provider, newState);
                                    },
                                    activeColor: interactiveColor,
                                    inactiveThumbColor: interactiveColor,
                                  ),
                                  PalladioText(
                                    "Squadra 2",
                                    type: PTextType.h3,
                                    bold: matchesFinProvider
                                            .selectedMatchBet?.finalResult ==
                                        "2",
                                  ),
                                ],
                              ),
                              const EmptySpace(
                                height: 10,
                              ),
                            ],
                          ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(matchBetContext).pop();
                          },
                          onSave: () async {
                            await matchesFinCallback.onMatchBetSaved(
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

  showMatchBottomSheet(
      BuildContext context, MatchesFinProvider provider) async {
    MatchesFinCallback matchesFinCallback = MatchesFinCallback();
    MatchesFinHandler matchesFinHandler = MatchesFinHandler();
    Matches? selectedMatch = provider.selectedMatch;
    if (selectedMatch == null) {
      return;
    }

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (matchBetContext) {
        var matchesFinProvider =
            Provider.of<MatchesFinProvider>(matchBetContext, listen: true);

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
                        MatchFinTile(
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
                        ResponsiveRow(
                          columnsCount: 100,
                          children: [
                            PalladioResponsiveFormField(
                              fieldTitle: "Squadra 1",
                              formField: SizedBox(
                                width: double.infinity,
                                child: TypedActionButtonWidget(
                                  displayedValue:
                                      matchesFinHandler.getTeamDescFromId(
                                              context, selectedMatch.idTeam1) ??
                                          "Nessuna selezione",
                                  onPressed: () async {
                                    await matchesFinCallback.onTeam1Pressed(
                                        context, matchesFinProvider);
                                  },
                                ),
                              ),
                            ),
                            PalladioResponsiveFormField(
                              fieldTitle: "Squadra 2",
                              formField: SizedBox(
                                width: double.infinity,
                                child: TypedActionButtonWidget(
                                  displayedValue:
                                      matchesFinHandler.getTeamDescFromId(
                                              context, selectedMatch.idTeam2) ??
                                          "Nessuna selezione",
                                  onPressed: () async {
                                    await matchesFinCallback.onTeam2Pressed(
                                        context, matchesFinProvider);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioText(
                          "Esito: ${matchesFinProvider.selectedMatch?.result ?? "Nessuno"}",
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
                                    matchesFinCallback.onMatchGoalTeam1Changed(
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
                                    matchesFinCallback.onMatchGoalTeam2Changed(
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
                        if (matchesFinProvider.selectedMatch?.result == "X")
                          Column(
                            children: [
                              const PalladioText(
                                "Vincente",
                                type: PTextType.h2,
                                bold: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PalladioText(
                                    "Squadra 1",
                                    type: PTextType.h3,
                                    bold: matchesFinProvider
                                            .selectedMatch?.finalResult ==
                                        "1",
                                  ),
                                  Switch(
                                    value: matchesFinProvider
                                            .selectedMatch?.finalResult ==
                                        "2",
                                    onChanged: (newState) {
                                      matchesFinCallback
                                          .onMatchFinalResultChanged(
                                              provider, newState);
                                    },
                                    activeColor: interactiveColor,
                                    inactiveThumbColor: interactiveColor,
                                  ),
                                  PalladioText(
                                    "Squadra 2",
                                    type: PTextType.h3,
                                    bold: matchesFinProvider
                                            .selectedMatch?.finalResult ==
                                        "2",
                                  ),
                                ],
                              ),
                              const EmptySpace(
                                height: 10,
                              ),
                            ],
                          ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(matchBetContext).pop();
                          },
                          onSave: () async {
                            await matchesFinCallback.onMatchSaved(
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
