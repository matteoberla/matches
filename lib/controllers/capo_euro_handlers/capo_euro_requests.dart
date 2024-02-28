import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';
import 'package:matches/models/capo_euro_models/capo_euro_bet_model.dart';

class CapoEuroRequests {
  Future getCapoEuroBetList(Map<String, String>? params, String all) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/capo_euro_bet/$all",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertCapoEuroBet(CapoEuroBet newCapoEuro) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newCapoEuro);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/capo_euro_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editCapoEuroBet(CapoEuroBet updatedCapoEuro) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedCapoEuro);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/capo_euro_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
