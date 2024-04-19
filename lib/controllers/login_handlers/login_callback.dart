import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/state_management/login_provider/login_provider.dart';

class LoginCallback {
  loginPressed(BuildContext context, LoginProvider provider, String username,
      String pass,
      {bool impersona = false}) async {
    LoginHandler loginHandler = LoginHandler();
    provider.updateUsername(username);
    provider.updatePassword(pass);
    await loginHandler.tryLogin(context, provider, impersona: impersona);
  }

  onSignupPressed(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/signup');
  }
}
