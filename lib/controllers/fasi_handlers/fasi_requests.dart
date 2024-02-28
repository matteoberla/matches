import 'package:http/http.dart' as http;
import 'package:matches/controllers/http_handler.dart';

class FasiRequests {
  Future getFasiList(Map<String, String>? params) async {
    var authHeader = await HttpHandler.getAuthorizationHeader();

    Map<String, String> headers = {};
    headers.addAll(authHeader);

    print(headers);

    http.Response response = await HttpHandler.get(
        HttpHandler.ipServer, "${HttpHandler.apiPath}/fasi",
        headers: headers, queryParameters: params, debugPrint: false);

    return response;
  }
}
