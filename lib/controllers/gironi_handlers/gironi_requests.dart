import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';
import 'package:matches/models/gironi_models/gironi_bet_model.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';

class GironiRequests {
  Future getGironiList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/gironi",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertGirone(Gironi newGironi) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newGironi);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/gironi'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editGirone(Gironi updatedGirone) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedGirone);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/gironi'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  deleteGirone(Gironi updatedGirone) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedGirone);

    http.Response response = await HttpHandler.delete(
        Uri.parse('${await HttpHandler.endpoint}/gironi'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }

  ///
  Future getGironiBetList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/gironi_bet",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  insertGironeBet(GironiBet newGironiBet) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(newGironiBet);

    http.Response response = await HttpHandler.post(
        Uri.parse('${await HttpHandler.endpoint}/gironi_bet'),
        headers: headers,
        body: body,
        debugPrint: true);

    return response;
  }

  editGironeBet(GironiBet updatedGironiBet) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    var body = json.encode(updatedGironiBet);

    http.Response response = await HttpHandler.put(
        Uri.parse('${await HttpHandler.endpoint}/gironi_bet'),
        headers: headers,
        body: body,
        debugPrint: false);

    return response;
  }
}
