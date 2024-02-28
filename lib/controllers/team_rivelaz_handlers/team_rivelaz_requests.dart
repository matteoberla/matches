import 'dart:convert';

import 'package:matches/controllers/http_handler.dart';
import 'package:http/http.dart' as http;
import 'package:matches/models/team_rivelaz_models/team_rivelaz_bet_model.dart';
import 'package:matches/models/team_rivelaz_models/team_rivelaz_model.dart';

class TeamRivelazRequests {
  Future getTeamRivelazBetList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/team_rivelaz_bet",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertTeamRivelazBet(TeamRivelazBet newTeamRivelaz) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newTeamRivelaz);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/team_rivelaz_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editTeamRivelazBet(TeamRivelazBet updatedTeamRivelaz) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedTeamRivelaz);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/team_rivelaz_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  ///
  Future getTeamRivelazList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/team_rivelaz",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  editTeamRivelaz(TeamRivelaz updatedTeamRivelaz) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedTeamRivelaz);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/team_rivelaz'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
