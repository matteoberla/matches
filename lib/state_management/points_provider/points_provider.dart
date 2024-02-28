import 'package:flutter/cupertino.dart';
import 'package:matches/models/points_models/points_model.dart';

class PointsProvider extends ChangeNotifier {
  List<Points> pointsList = [];

  overridePointsList(List<Points> newList) {
    pointsList = List.from(newList);
    notifyListeners();
  }
}
