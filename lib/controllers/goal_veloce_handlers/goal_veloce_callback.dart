import 'package:flutter/material.dart';
import 'package:matches/controllers/goal_veloce_handlers/goal_veloce_handler.dart';
import 'package:matches/state_management/goal_veloce_provider/goal_veloce_provider.dart';

class GoalVeloceCallback {
  onTeamBetPressed(BuildContext context, GoalVeloceProvider provider) async {
    GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
    await goalVeloceHandler.editTeamBet(context, provider);
  }

  onTeamPressed(BuildContext context, GoalVeloceProvider provider) async {
    GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
    await goalVeloceHandler.editTeam(context, provider);
  }

  onSaveBetPressed(BuildContext context, GoalVeloceProvider provider) async {
    GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
    await goalVeloceHandler.verifyGoalVeloceBet(context, provider);
  }

  onSavePressed(BuildContext context, GoalVeloceProvider provider) async {
    GoalVeloceHandler goalVeloceHandler = GoalVeloceHandler();
    await goalVeloceHandler.verifyGoalVeloce(context, provider);
  }

  onImpostaRisultatoPressed(BuildContext context, GoalVeloceProvider provider) {
    provider.updateShowFinalResult();
  }
}
