import 'package:flutter/cupertino.dart';
import 'package:matches/models/capo_euro_models/capo_euro_bet_model.dart';

class CapoEuroProvider extends ChangeNotifier {
  List<CapoEuroBet>? capoEuroBetList;

  overrideCapoEuroBetList(List<CapoEuroBet> newList) {
    capoEuroBetList = List.from(newList);
    notifyListeners();
  }

  ///
  List<CapoEuroBet> usersCapoEuroBetList = [];

  overrideUsersCapoEuroBetList(List<CapoEuroBet> newList) {
    usersCapoEuroBetList = List.from(newList);
    notifyListeners();
  }

  int get usersCapoEuroBetListLength {
    return usersCapoEuroBetList.length;
  }

  bool showUsersBetList = false;

  toggleShowUsersBetList() {
    showUsersBetList = !showUsersBetList;
    notifyListeners();
  }
}
