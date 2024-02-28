import 'package:flutter/cupertino.dart';

class TestProvider extends ChangeNotifier {

  bool test = true;

  void updateTest(bool newValue) {
    test = newValue;
    notifyListeners();
  }

}