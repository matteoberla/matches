import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/controllers/team_rivelaz_handlers/team_rivelaz_callback.dart';
import 'package:matches/controllers/team_rivelaz_handlers/team_rivelaz_handler.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_bet_model.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_model.dart';
import 'package:matches/state_management/team_rivelaz_provider/team_rivelaz_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class TeamRivelazPage extends StatefulWidget {
  const TeamRivelazPage({super.key});

  @override
  State<TeamRivelazPage> createState() => _TeamRivelazPageState();
}

class _TeamRivelazPageState extends State<TeamRivelazPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  SetupCallback setupCallback = SetupCallback();
  TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
  TeamRivelazCallback teamRivelazCallback = TeamRivelazCallback();
  LoginHandler loginHandler = LoginHandler();

  @override
  Widget build(BuildContext context) {
    var teamRivelazProvider =
        Provider.of<TeamRivelazProvider>(context, listen: true);

    TeamRivelazBet? selectedTeamRivelazBet = teamRivelazProvider.teamRivelazBet;
    TeamRivelaz? selectedTeamRivelaz = teamRivelazProvider.teamRivelaz;

    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Team rivelazione",
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            setupCallback.onMenuPressed(context, _key);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: PalladioBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: loginHandler.currentUserIsAdmin(context),
                  child: Row(
                    children: [
                      PalladioActionButton(
                          title: teamRivelazProvider.showFinalResult
                              ? "Indietro"
                              : "Imposta risultato",
                          onTap: () async {
                            await teamRivelazCallback.onImpostaRisultatoPressed(
                                context, teamRivelazProvider);
                          },
                          backgroundColor: interactiveColor),
                    ],
                  ),
                ),
                Visibility(
                  visible: teamRivelazProvider.showFinalResult,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PalladioText(
                        "Squadra effettiva:",
                        type: PTextType.h2,
                        bold: true,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TypedActionButtonWidget(
                          displayedValue: teamRivelazHandler.getTeamDescFromId(
                                  context, selectedTeamRivelaz?.idTeam) ??
                              "Nessuna selezione",
                          onPressed: () async {
                            await teamRivelazCallback.onTeamPressed(
                                context, teamRivelazProvider);
                          },
                        ),
                      ),
                      const EmptySpace(
                        height: 10,
                      ),
                      Row(
                        children: [
                          PalladioActionButton(
                            title: "Salva",
                            onTap: () async {
                              teamRivelazCallback.onSavePressed(
                                  context, teamRivelazProvider);
                            },
                            backgroundColor: interactiveColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: teamRivelazProvider.showFinalResult == false,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TypedActionButtonWidget(
                          displayedValue: teamRivelazHandler.getTeamDescFromId(
                                  context, selectedTeamRivelazBet?.idTeam) ??
                              "Nessuna selezione",
                          onPressed: () async {
                            await teamRivelazCallback.onTeamBetPressed(
                                context, teamRivelazProvider);
                          },
                        ),
                      ),
                      Visibility(
                        visible: selectedTeamRivelazBet?.points != null,
                        child: const EmptySpace(
                          height: 10,
                        ),
                      ),
                      Visibility(
                        visible: selectedTeamRivelazBet?.points != null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.control_point_duplicate_sharp,
                              color: interactiveColor,
                            ),
                            const EmptySpace(
                              width: 5,
                            ),
                            PalladioText(
                              "Punti: ${selectedTeamRivelazBet?.points}",
                              type: PTextType.h3,
                              textColor: opaqueTextColor,
                            ),
                          ],
                        ),
                      ),
                      const EmptySpace(
                        height: 10,
                      ),
                      Row(
                        children: [
                          PalladioActionButton(
                            title: "Salva",
                            onTap: () async {
                              teamRivelazCallback.onSaveBetPressed(
                                  context, teamRivelazProvider);
                            },
                            backgroundColor: interactiveColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: PalladioDrawer(
        drawerKey: _key,
      ),
    );
  }
}
