import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/state_management/login_provider/login_provider.dart';

class LoginCallback {
  loginPressed(BuildContext context, LoginProvider provider, String username,
      String pass) async {
    LoginHandler loginHandler = LoginHandler();
    provider.updateUsername(username);
    provider.updatePassword(pass);
    await loginHandler.tryLogin(context, provider);
  }

  onSignupPressed(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/signup');
  }
}
