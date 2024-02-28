import 'package:flutter/cupertino.dart';
import 'package:matches/models/login_models/login_model.dart';

class LoginProvider extends ChangeNotifier{

  String username = "";

  updateUsername(String newText){
    username = newText;
    notifyListeners();
  }

  String password = "";

  updatePassword(String newText){
    password = newText;
    notifyListeners();
  }

  ///login model
  LoginModel? currentUser;

  updateCurrentUser(LoginModel newUser){
    currentUser = newUser;
    notifyListeners();
  }
}