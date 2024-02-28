import 'package:flutter/cupertino.dart';
import 'package:matches/models/gironi_models/gironi_bet_model.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';

class GironiProvider extends ChangeNotifier {
  ///gironi
  List<Gironi> gironiList = [];

  overrideGironiList(List<Gironi> newList) {
    gironiList = List.from(newList);
    notifyListeners();
  }

  Gironi? selectedGirone;

  updateSelectedGirone(Gironi? newSelected) {
    selectedGirone = newSelected;
    notifyListeners();
  }

  updateTeam1OfSelectedGirone(int? newTeam) {
    selectedGirone?.idTeam1 = newTeam;
    notifyListeners();
  }

  updateTeam2OfSelectedGirone(int? newTeam) {
    selectedGirone?.idTeam2 = newTeam;
    notifyListeners();
  }

  updateTeam3OfSelectedGirone(int? newTeam) {
    selectedGirone?.idTeam3 = newTeam;
    notifyListeners();
  }

  updateTeam4OfSelectedGirone(int? newTeam) {
    selectedGirone?.idTeam4 = newTeam;
    notifyListeners();
  }

  ///gironi bet
  List<GironiBet> gironiBetList = [];

  overrideGironiBetList(List<GironiBet> newList) {
    gironiBetList = List.from(newList);
    notifyListeners();
  }

  GironiBet? selectedGironeBet;

  updateSelectedGironeBet(GironiBet? newSelected) {
    selectedGironeBet = newSelected;
    notifyListeners();
  }
}
