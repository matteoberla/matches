import 'package:flutter/cupertino.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_bet_model.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_model.dart';

class GoalVeloceProvider extends ChangeNotifier {
  GoalVeloce? goalVeloce;

  updateGoalVeloce(GoalVeloce? newGoalVeloce) {
    goalVeloce = newGoalVeloce;
    notifyListeners();
  }

  bool showFinalResult = false;

  updateTeamOfGoalVeloce(int? newTeamId) {
    goalVeloce?.idTeam = newTeamId;
    notifyListeners();
  }

  updateShowFinalResult() {
    showFinalResult = !showFinalResult;
    notifyListeners();
  }

  ///

  GoalVeloceBet? goalVeloceBet;

  updateGoalVeloceBet(GoalVeloceBet? newBet) {
    goalVeloceBet = newBet;
    notifyListeners();
  }

  updateTeamOfGoalVeloceBet(int? newTeamId) {
    goalVeloceBet?.idTeam = newTeamId;
    notifyListeners();
  }
}
