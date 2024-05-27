import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/controllers/goal_veloce_handlers/goal_veloce_callback.dart';
import 'package:matches/controllers/goal_veloce_handlers/goal_veloce_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_bet_model.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_model.dart';
import 'package:matches/state_management/goal_veloce_provider/goal_veloce_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class GoalVelocePage extends StatefulWidget {
  const GoalVelocePage({super.key});

  @override
  State<GoalVelocePage> createState() => _GoalVelocePageState();
}

class _GoalVelocePageState extends State<GoalVelocePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  SetupCallback setupCallback = SetupCallback();
  GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
  GoalVeloceCallback goalVeloceCallback = GoalVeloceCallback();
  LoginHandler loginHandler = LoginHandler();

  @override
  Widget build(BuildContext context) {
    var goalVeloceProvider =
        Provider.of<GoalVeloceProvider>(context, listen: true);

    GoalVeloceBet? selectedGoalVeloceBet = goalVeloceProvider.goalVeloceBet;
    GoalVeloce? selectedGoalVeloce = goalVeloceProvider.goalVeloce;

    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Goal veloce",
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
                  visible: loginHandler.currentUserIsAdminOrImpersona(context),
                  child: Row(
                    children: [
                      PalladioActionButton(
                          title: goalVeloceProvider.showFinalResult
                              ? "Indietro"
                              : "Imposta risultato",
                          onTap: () async {
                            await goalVeloceCallback.onImpostaRisultatoPressed(
                                context, goalVeloceProvider);
                          },
                          backgroundColor: interactiveColor),
                    ],
                  ),
                ),
                Visibility(
                  visible: goalVeloceProvider.showFinalResult,
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
                          displayedValue: goalVeloceHandler.getTeamDescFromId(
                                  context, selectedGoalVeloce?.idTeam) ??
                              "Nessuna selezione",
                          onPressed: () async {
                            await goalVeloceCallback.onTeamPressed(
                                context, goalVeloceProvider);
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
                              goalVeloceCallback.onSavePressed(
                                  context, goalVeloceProvider);
                            },
                            backgroundColor: interactiveColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: goalVeloceProvider.showFinalResult == false,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TypedActionButtonWidget(
                          displayedValue: goalVeloceHandler.getTeamDescFromId(
                                  context, selectedGoalVeloceBet?.idTeam) ??
                              "Nessuna selezione",
                          onPressed: () async {
                            await goalVeloceCallback.onTeamBetPressed(
                                context, goalVeloceProvider);
                          },
                        ),
                      ),
                      Visibility(
                        visible: selectedGoalVeloceBet?.points != null,
                        child: const EmptySpace(
                          height: 10,
                        ),
                      ),
                      Visibility(
                        visible: selectedGoalVeloceBet?.points != null,
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
                              "Punti: ${selectedGoalVeloceBet?.points}",
                              type: PTextType.h3,
                              textColor: interactiveColor,
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
                              goalVeloceCallback.onSaveBetPressed(
                                  context, goalVeloceProvider);
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
