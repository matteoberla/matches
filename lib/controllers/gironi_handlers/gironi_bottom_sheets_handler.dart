import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/gironi_components/girone_pos_row.dart';
import 'package:matches/components/gironi_components/girone_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/gironi_handlers/gironi_callback.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/gironi_models/gironi_bet_model.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class GironiBottomSheetsHandler {
  showBetBottomSheet(BuildContext context, GironiProvider provider) async {
    GironiCallback gironiCallback = GironiCallback();
    Gironi? selectedGirone = provider.selectedGirone;
    if (selectedGirone == null) {
      return;
    }
    LoginHandler loginHandler = LoginHandler();
    GironiBet? selectedGironeBet = provider.selectedGironeBet;
    if (selectedGironeBet == null) {
      LoginModel? currentUser = loginHandler.getCurrentUser(context);
      //nuova scommessa
      GironiBet newGironeBet =
          GironiBet(userId: currentUser?.id, girone: selectedGirone.girone);
      provider.updateSelectedGironeBet(newGironeBet);
      selectedGironeBet = provider.selectedGironeBet;
    }

    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    TeamsHandler teamsHandler = TeamsHandler();
    Teams? team1 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam1);
    Teams? team2 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam2);
    Teams? team3 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam3);
    Teams? team4 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam4);

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (gironiBetContext) {
        var gironiProvider =
            Provider.of<GironiProvider>(gironiBetContext, listen: true);

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
                              loginHandler.currentUserIsAdmin(gironiBetContext),
                          child: Row(
                            children: [
                              PalladioActionButton(
                                  title: "Imposta risultato",
                                  onTap: () async {
                                    Navigator.of(gironiBetContext).pop();
                                    await gironiCallback
                                        .onImpostaRisultatoPressed(context,
                                            gironiProvider, selectedGirone);
                                  },
                                  backgroundColor: interactiveColor),
                            ],
                          ),
                        ),
                        GironeTile(
                          girone: selectedGirone,
                          activeActions: false,
                        ),
                        const PalladioText(
                          "Il tuo risultato",
                          type: PTextType.h1,
                          bold: true,
                        ),
                        GironePosRow(
                            team: team1,
                            posController: selectedGironeBet?.pos1Controller),
                        GironePosRow(
                            team: team2,
                            posController: selectedGironeBet?.pos2Controller),
                        GironePosRow(
                            team: team3,
                            posController: selectedGironeBet?.pos3Controller),
                        GironePosRow(
                            team: team4,
                            posController: selectedGironeBet?.pos4Controller),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(gironiBetContext).pop();
                          },
                          onSave: () async {
                            await gironiCallback.onGironeBetSaved(
                                gironiBetContext, provider);
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

  showGironeBottomSheet(BuildContext context, GironiProvider provider) async {
    GironiCallback gironiCallback = GironiCallback();
    Gironi? selectedGirone = provider.selectedGirone;
    if (selectedGirone == null) {
      return;
    }
    // init campi
    selectedGirone.gironeController.text = selectedGirone.girone ?? "";
    //
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    TeamsHandler teamsHandler = TeamsHandler();
    Teams? team1 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam1);
    Teams? team2 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam2);
    Teams? team3 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam3);
    Teams? team4 =
        teamsHandler.getTeamById(teamsProvider, selectedGirone.idTeam4);

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (gironiBetContext) {
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
                        GironeTile(
                          girone: selectedGirone,
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
                        GironePosRow(
                            team: team1,
                            posController: selectedGirone.pos1Controller),
                        GironePosRow(
                            team: team2,
                            posController: selectedGirone.pos2Controller),
                        GironePosRow(
                            team: team3,
                            posController: selectedGirone.pos3Controller),
                        GironePosRow(
                            team: team4,
                            posController: selectedGirone.pos4Controller),
                        const EmptySpace(
                          height: 10,
                        ),
                        PalladioRowActionButtons(
                          onExit: () {
                            Navigator.of(gironiBetContext).pop();
                          },
                          onSave: () async {
                            await gironiCallback.onGironeSaved(
                                gironiBetContext, provider);
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
