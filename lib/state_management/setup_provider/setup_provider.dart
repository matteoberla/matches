import 'package:flutter/cupertino.dart';

class SetupProvider extends ChangeNotifier {
  String version = "";
  String build = "";

  updateAppInfo(String newVersion, String newBuild) {
    version = newVersion;
    build = newBuild;
    notifyListeners();
  }
}
