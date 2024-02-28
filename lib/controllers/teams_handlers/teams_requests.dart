import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';
import 'package:matches/models/teams_models/teams_model.dart';

class TeamsRequests {
  Future getTeamsList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/teams",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertTeam(Teams newTeam) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newTeam);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/teams'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editTeam(Teams updatedTeam) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedTeam);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/teams'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  deleteTeam(Teams updatedTeam) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedTeam);

    http.Response response = await HttpHandler.delete(
        Uri.parse('${await HttpHandler.endpoint}/teams'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
