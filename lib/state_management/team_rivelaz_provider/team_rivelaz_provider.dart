import 'package:flutter/cupertino.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_bet_model.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_model.dart';

class TeamRivelazProvider extends ChangeNotifier {
  TeamRivelaz? teamRivelaz;

  updateTeamRivelaz(TeamRivelaz? newTeamRivelaz) {
    teamRivelaz = newTeamRivelaz;
    notifyListeners();
  }

  bool showFinalResult = false;

  updateTeamOfTeamRivelaz(int? newTeamId) {
    teamRivelaz?.idTeam = newTeamId;
    notifyListeners();
  }

  updateShowFinalResult() {
    showFinalResult = !showFinalResult;
    notifyListeners();
  }

  ///

  TeamRivelazBet? teamRivelazBet;

  updateTeamRivelazBet(TeamRivelazBet? newBet) {
    teamRivelazBet = newBet;
    notifyListeners();
  }

  updateTeamOfTeamRivelazBet(int? newTeamId) {
    teamRivelazBet?.idTeam = newTeamId;
    notifyListeners();
  }
}
