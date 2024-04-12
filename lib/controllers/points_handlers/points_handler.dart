import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_bottom_sheet_handler.dart';
import 'package:matches/controllers/points_handlers/points_requests.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:provider/provider.dart';

class PointsHandler {
  Future saveAllPoints(BuildContext context) async {
    var pointsProvider = Provider.of<PointsProvider>(context, listen: false);
    PointsRequests pointsRequests = PointsRequests();

    Map<String, String> params = {};

    http.Response userPointsResponse =
        await pointsRequests.getUsersPoints(params);

    if (userPointsResponse.statusCode == 200) {
      PointsModel pointsModel =
          PointsModel.fromJson(json.decode(userPointsResponse.body));
      pointsProvider.overridePointsList(pointsModel.points ?? []);
    }
  }

  Points? getCurrentUserPoints(BuildContext context) {
    LoginHandler loginHandler = LoginHandler();
    LoginModel? currentUser = loginHandler.getCurrentUser(context);
    //
    if (currentUser != null) {
      var pointsProvider = Provider.of<PointsProvider>(context, listen: false);
      return pointsProvider.pointsList
          .where((element) => element.userId == currentUser.id)
          .firstOrNull;
    } else {
      return null;
    }
  }

  openPointsBottomSheet(BuildContext context, Points userPoints) async {
    PointsBottomSheetHandler pointsBottomSheetHandler =
        PointsBottomSheetHandler();
    await pointsBottomSheetHandler.openPointsBottomSheet(context, userPoints);
  }

  Future<bool> toggleUserActive(BuildContext context, Points userPoints) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    PointsRequests pointsRequests = PointsRequests();

    Map<String, String> params = {};

    http.Response toggleUserStatusResponse = await pointsRequests
        .toggleUserIsActivePoints(params, userPoints.userId.toString());

    httpProvider.updateLoadingState(false);

    if (toggleUserStatusResponse.statusCode == 200) {
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        PointsHandler pointsHandler = PointsHandler();
        await pointsHandler.saveAllPoints(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }
    return false;
  }

  String getUsersPoints(PointsProvider provider) {
    String export = "Ecco la classifica:\n\n";

    int pos = 1;
    List<String> positionsEmoji = ["🥇", "🥈", "🥉"];
    for (var userPoints in provider.pointsList) {
      //esporto solo utenti attivi
      if (userPoints.isActive == 1) {
        if (pos <= 3) {
          export += positionsEmoji[pos - 1];
        } else {
          export += pos.toString();
        }
        export += ". ${userPoints.username} ${userPoints.totalPoints} Pt\n";
        pos++;
      }
    }

    return export;
  }
}
