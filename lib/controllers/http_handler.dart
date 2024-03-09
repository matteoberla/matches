import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:matches/controllers/fatal_error_handler.dart';
import 'package:matches/controllers/persistent_data_handlers/login_shared_preferences.dart';
import 'package:matches/main.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';

class HttpHandler {
  static Logger logger = Logger();

  static get ipServer {
    //TODO modifica endpoint
    //return "https://em2024.netsons.org";
    //return "http://berlatidns.hopto.org:8081";
    return "http://localhost";
  }

  static get endpoint async {
    return "$ipServer$apiPath";
    //static String endpoint = "192.168.1.61";
  }

  static get apiPath {
    return "/matches_api";
  }

  ///debug print
  static writeRequestDetails(
      String type, String uri, String body, bool debugPrint) {
    logger.i("Req[$type] - uri: $uri, body: $body");
  }

  static writeResponseDetails(String uri, int statusCode, String body,
      String? reason, bool debugPrint) {
    if (debugPrint) {
      logger.v("Res[$statusCode], body: $body, reason: $reason");
    } else {
      logger.v("Res[$statusCode] - uri: $uri, reason: $reason");
    }
  }

  ///get header
  static Future<Map<String, String>> getAuthorizationHeader() async {
    String accessToken = await LoginSharedPreferences.accessToken;
    Map<String, String> authorizationHeader = {
      "Authorization": "Bearer $accessToken",
    };
    return authorizationHeader;
  }

  ///----------------------------richieste--------------------------------------
  static Duration timeoutDuration = const Duration(seconds: 30);

  static Future<http.Response> onTimeout() async {
    return http.Response('Timeout Richiesta', 408);
  }

  static Future<http.Response> get(String url, String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      debugPrint = false}) async {
    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);

    final uri =
        Uri.parse("$url$endpoint").replace(queryParameters: queryParameters);

    writeRequestDetails(
        "GET", uri.toString(), queryParameters?.toString() ?? "", debugPrint);
    http.Response response;
    try {
      /*
      final queryParameters = {
        'param1': 'one',
        'param2': 'two',
        "p3": ["1", "2", "3"]
      };
      */
      response = await http
          .get(uri, headers: headers)
          .timeout(timeoutDuration, onTimeout: onTimeout);
    } catch (e) {
      print(e);

      httpProvider.updateLoadingState(false);
      response = http.Response('Server non raggiungibile', 503);
      debugPrint = true;
    }
    writeResponseDetails(uri.toString(), response.statusCode, response.body,
        response.reasonPhrase, debugPrint);
    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.notifyUserWithReceivedResponse(
        response, uri.toString(), queryParameters.toString(), "GET");

    return response;
  }

  static Future<http.Response> post(Uri uri,
      {Map<String, String>? headers, Object? body, debugPrint = false}) async {
    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    writeRequestDetails("POST", uri.toString(), body.toString(), debugPrint);
    http.Response response;
    try {
      response = await http
          .post(uri, headers: headers, body: body)
          .timeout(timeoutDuration, onTimeout: onTimeout);
    } catch (e) {
      print("POST err: $e");

      httpProvider.updateLoadingState(false);
      response = http.Response('Server non raggiungibile', 503);
      debugPrint = true;
    }
    writeResponseDetails(uri.toString(), response.statusCode, response.body,
        response.reasonPhrase, debugPrint);

    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.notifyUserWithReceivedResponse(
        response, uri.toString(), body.toString(), "POST");
    return response;
  }

  static Future<http.Response> put(Uri uri,
      {Map<String, String>? headers, Object? body, debugPrint = false}) async {
    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    writeRequestDetails("PUT", uri.toString(), body.toString(), debugPrint);
    http.Response response;
    try {
      response = await http
          .put(uri, headers: headers, body: body)
          .timeout(timeoutDuration, onTimeout: onTimeout);
    } catch (e) {
      print(e);

      httpProvider.updateLoadingState(false);
      response = http.Response('Server non raggiungibile', 503);
      debugPrint = true;
    }

    writeResponseDetails(uri.toString(), response.statusCode, response.body,
        response.reasonPhrase, debugPrint);

    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.notifyUserWithReceivedResponse(
        response, uri.toString(), body.toString(), "PUT");

    return response;
  }

  static Future<http.Response> delete(Uri uri,
      {Map<String, String>? headers, Object? body, debugPrint = false}) async {
    var httpProvider = Provider.of<HttpProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    writeRequestDetails("DELETE", uri.toString(), body.toString(), debugPrint);
    http.Response response;
    try {
      response = await http
          .delete(uri, headers: headers, body: body)
          .timeout(timeoutDuration, onTimeout: onTimeout);
    } catch (e) {
      print(e);

      httpProvider.updateLoadingState(false);
      response = http.Response('Server non raggiungibile', 503);
      debugPrint = true;
    }

    writeResponseDetails(uri.toString(), response.statusCode, response.body,
        response.reasonPhrase, debugPrint);

    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.notifyUserWithReceivedResponse(
        response, uri.toString(), body.toString(), "DELETE");

    return response;
  }
}
