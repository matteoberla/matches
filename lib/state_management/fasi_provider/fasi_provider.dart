import 'package:flutter/cupertino.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';

class FasiProvider extends ChangeNotifier {
  List<Fasi> fasiList = [];

  overrideFasiList(List<Fasi> newList) {
    fasiList = List.from(newList);
    notifyListeners();
  }
}
