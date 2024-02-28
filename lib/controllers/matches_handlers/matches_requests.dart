import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';

class MatchesRequests {
  Future getMatchesList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/matches",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertMatch(Matches newMatch) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newMatch);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/matches'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editMatch(Matches updatedMatch) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedMatch);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/matches'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  deleteMatch(Matches updatedMatch) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedMatch);

    http.Response response = await HttpHandler.delete(
        Uri.parse('${await HttpHandler.endpoint}/matches'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  ///

  Future getMatchesBetList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/matches_bet",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertMatchBet(MatchesBet newMatchBet) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newMatchBet);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/matches_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editMatchBet(MatchesBet updatedMatchBet) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedMatchBet);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/matches_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
