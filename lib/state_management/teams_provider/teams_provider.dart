import 'package:flutter/cupertino.dart';
import 'package:matches/models/teams_models/teams_model.dart';

class TeamsProvider extends ChangeNotifier {
  ///Lista squadre
  List<Teams> teamsList = [];

  overrideTeamsList(List<Teams> newList) {
    teamsList = List.from(newList);
    notifyListeners();
  }

  int get teamsListLength {
    return teamsList.length;
  }

  //
  Teams? selectedTeam;

  updateSelectedTeam(Teams? newSelected) {
    selectedTeam = newSelected;
    notifyListeners();
  }
}
