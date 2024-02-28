import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_requests.dart';
import 'package:matches/models/login_models/signup_model.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';

class SignupHandler {
  trySignup(BuildContext context, String username, String password,
      String nickname) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    LoginRequests loginRequests = LoginRequests();

    Map<String, String> params = {
      "name": nickname,
      "email": username,
      "password": password
    };

    http.Response signupResponse = await loginRequests.register(params);

    httpProvider.updateLoadingState(false);
    if (signupResponse.statusCode == 200) {
      SignupModel signupModel =
          SignupModel.fromJson(json.decode(signupResponse.body));
      if (signupModel.message == "") {
        return true;
      } else {
        await Alerts.showErrorAlertNoContext(
            "Attenzione!", signupModel.message ?? "Errore generico");
      }
    }
    return false;
  }
}
