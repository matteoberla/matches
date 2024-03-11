import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/main.dart';
import 'package:matches/screens/fatal_error.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';

class FatalErrorHandler {
  notifyUserWithReceivedResponse(http.Response response, String uri,
      String queryParameters, String method) {
    StackTrace stackTraceGetRequest = StackTrace.fromString(
        "\nNetwork exception while making[$method]: $uri \n\nwith ${method == "GET" ? "queryParameters" : "body"}:$queryParameters\n\nresponse[${response.statusCode}]:${response.body.toString()}");

    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);

    if (response.statusCode == 401) {
      print("401 - Login scaduto");
      Navigator.of(navigatorKey.currentState!.context).pushNamedAndRemoveUntil(
          '/login', (route) => route.settings.name == '/login');
      httpProvider.updateLoadingState(false);
      //server401("Network Error - Login error", stackTraceGetRequest);
    } else if (response.statusCode == 404) {
      server404("Network Error - Not found", stackTraceGetRequest);
      httpProvider.updateLoadingState(false);
    } else if (response.statusCode == 408) {
      server408("Network Error - Timeout", stackTraceGetRequest);
      httpProvider.updateLoadingState(false);
    } else if (response.statusCode == 503) {
      server503("Network Error - Not available", stackTraceGetRequest);
      httpProvider.updateLoadingState(false);
    } else if (response.statusCode == 500) {
      fatalError("Network Error", stackTraceGetRequest);
      httpProvider.updateLoadingState(false);
    } else if (response.statusCode == 200) {
      //RESPONSE OK
    } else {
      fatalError(
          "${response.statusCode} - Network Error", stackTraceGetRequest);
      httpProvider.updateLoadingState(false);
    }
  }

  showFatalErrorAlert(
      String title, String description, Object error, StackTrace stackTrace) {
    Alerts.showFatalErrorAlertNoContext(title, description, () {
      Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) =>
              FatalErrorPage(error: error.toString(), stackTrace: stackTrace),
        ),
      );
    }, () {
      returnToParentPage();
      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentState!.context, '/login', (route) => false);
    });
  }

  returnToParentPage() {
    print("return to parent");
  }

  void fatalError(Object error, StackTrace stackTrace) {
    Logger logger = Logger();
    logger.e("Errore!", [error.toString(), stackTrace]);
    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    httpProvider.updateLoadingState(false);
    //cron.close();
    showFatalErrorAlert(
        "Errore",
        "L'App ha riscontrato un problema. Riprova più tardi",
        error,
        stackTrace);
  }

  server404(Object error, StackTrace stackTrace) {
    showFatalErrorAlert("Errore", "Url non trovato", error, stackTrace);
  }

  server503(Object error, StackTrace stackTrace) {
    showFatalErrorAlert(
        "Errore", "Server non raggiungibile", error, stackTrace);
  }

  server408(Object error, StackTrace stackTrace) {
    showFatalErrorAlert(
        "Errore", "La richiesta ha impiegato troppo tempo", error, stackTrace);
  }

  server401(Object error, StackTrace stackTrace) {
    showFatalErrorAlert(
        "Errore", "Login scaduto o non valido", error, stackTrace);
  }
}
