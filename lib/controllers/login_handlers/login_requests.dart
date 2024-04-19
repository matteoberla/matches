import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';

class LoginRequests {
  Future home() async {
    //var headers = {'Content-Type': 'application/json'};
    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/home",
        headers: null, debugPrint: false);

    return response;
  }

  Future login(Map<String, String> params) async {
    Map<String, String> headers = {};

    var body = json.encode(params);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/login'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  Future register(Map<String, String> params) async {
    Map<String, String> headers = {};

    var body = json.encode(params);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/register'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  Future impersona(Map<String, String> params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(params);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/impersona'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
