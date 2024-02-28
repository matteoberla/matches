import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';

class PointsRequests {
  Future getUsersPoints(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/user_points",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }

  Future toggleUserIsActivePoints(
      Map<String, String>? params, String userId) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/user_status/$userId",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }
}
