import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_bet_model.dart';
import 'package:matches/models/goal_veloce_models/goal_veloce_model.dart';

class GoalVeloceRequests {
  Future getGoalVeloceBetList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/goal_veloce_bet",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertGoalVeloceBet(GoalVeloceBet newGoalVeloce) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newGoalVeloce);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/goal_veloce_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editGoalVeloceBet(GoalVeloceBet updatedGoalVeloce) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedGoalVeloce);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/goal_veloce_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  ///
  Future getGoalVeloceList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/goal_veloce",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  editGoalVeloce(GoalVeloce updatedGoalVeloce) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedGoalVeloce);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/goal_veloce'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
