import 'package:flutter/cupertino.dart';
import 'package:matches/models/capo_azz_models/capo_azz_bet_model.dart';

class CapoAzzProvider extends ChangeNotifier {
  List<CapoAzzBet>? capoAzzBetList;

  overrideCapoAzzBetList(List<CapoAzzBet> newList) {
    capoAzzBetList = List.from(newList);
    notifyListeners();
  }

  ///
  List<CapoAzzBet> usersCapoAzzBetList = [];

  overrideUsersCapoAzzBetList(List<CapoAzzBet> newList) {
    usersCapoAzzBetList = List.from(newList);
    notifyListeners();
  }

  int get usersCapoAzzBetListLength {
    return usersCapoAzzBetList.length;
  }

  bool showUsersBetList = false;

  toggleShowUsersBetList() {
    showUsersBetList = !showUsersBetList;
    notifyListeners();
  }
}
