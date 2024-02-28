import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/signup_handlers/signup_handler.dart';

class SignupCallback {
  onSignupPressed(
      BuildContext context, String username, password, nickname) async {
    SignupHandler signupHandler = SignupHandler();
    bool signedup =
        await signupHandler.trySignup(context, username, password, nickname);
    if (signedup) {
      await Alerts.showInfoAlertNoContext("Successo",
          "La tua registrazione è andata a buon fine, accedi per giocare!");
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  onLoginPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
