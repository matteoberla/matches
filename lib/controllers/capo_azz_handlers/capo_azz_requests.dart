import 'dart:convert';

import 'package:matches/controllers/http_handler.dart';
import 'package:http/http.dart' as http;
import 'package:matches/models/capo_azz_models/capo_azz_bet_model.dart';

class CapoAzzRequests {
  Future getCapoAzzBetList(Map<String, String>? params, String all) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/capo_azz_bet/$all",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertCapoAzzBet(CapoAzzBet newCapoEuro) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newCapoEuro);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/capo_azz_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editCapoAzzBet(CapoAzzBet updatedCapoEuro) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedCapoEuro);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/capo_azz_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
