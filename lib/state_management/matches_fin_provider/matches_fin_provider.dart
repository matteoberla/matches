import 'package:flutter/cupertino.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';

class MatchesFinProvider extends ChangeNotifier {
  ///lista partite
  List<Matches> matchesList = [];

  overrideMatchesList(List<Matches> newList) {
    matchesList = List.from(newList);
    notifyListeners();
  }

  int get matchesListLength {
    return matchesList.length;
  }

  Matches? selectedMatch;

  updateSelectedMatch(Matches? newSelected) {
    selectedMatch = newSelected;
    notifyListeners();
  }

  updateResultOfSelectedMatch(String? result) {
    selectedMatch?.result = result;
    //print(result);
    notifyListeners();
  }

  updateDataOfSelectedMatch(String? newDate) {
    selectedMatch?.date = newDate;
    notifyListeners();
  }

  updateFaseOfSelectedMatch(int? newFase) {
    selectedMatch?.fase = newFase;
    notifyListeners();
  }

  updateTeam1OfSelectedMatch(int? newTeam) {
    selectedMatch?.idTeam1 = newTeam;
    notifyListeners();
  }

  updateTeam2OfSelectedMatch(int? newTeam) {
    selectedMatch?.idTeam2 = newTeam;
    notifyListeners();
  }

  ///lista scommesse partite
  List<MatchesBet> matchesBetList = [];

  overrideMatchesBetList(List<MatchesBet> newList) {
    matchesBetList = List.from(newList);
    notifyListeners();
  }

  ///selected matchBet
  MatchesBet? selectedMatchBet;

  updateSelectedMatchBet(MatchesBet? newSelected) {
    selectedMatchBet = newSelected;
    notifyListeners();
  }

  updateTeam1OfSelectedMatchBet(int? newTeam) {
    selectedMatchBet?.idTeam1 = newTeam;
    notifyListeners();
  }

  updateTeam2OfSelectedMatchBet(int? newTeam) {
    selectedMatchBet?.idTeam2 = newTeam;
    notifyListeners();
  }

  updateGoal1OfSelectedMatchBet(int? goal1) {
    selectedMatchBet?.goalTeam1 = goal1;
  }

  updateGoal2OfSelectedMatchBet(int? goal2) {
    selectedMatchBet?.goalTeam2 = goal2;
  }

  updateResultOfSelectedMatchBet(String? result) {
    selectedMatchBet?.result = result;
    //print(result);
    notifyListeners();
  }
}
