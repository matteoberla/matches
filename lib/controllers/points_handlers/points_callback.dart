import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/models/points_models/points_model.dart';

class PointsCallback {
  onUserPointsTap(BuildContext context, Points? userPoints) async {
    if (userPoints != null) {
      PointsHandler pointsHandler = PointsHandler();
      await pointsHandler.openPointsBottomSheet(context, userPoints);
    }
  }

  onToggleUserStatus(BuildContext context, Points userPoints) async {
    PointsHandler pointsHandler = PointsHandler();
    bool success = await pointsHandler.toggleUserActive(context, userPoints);

    if (success && context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
