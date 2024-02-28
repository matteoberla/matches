import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_callback.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/styles.dart';

class PalladioBottomBar extends StatelessWidget {
  PalladioBottomBar({
    super.key,
  });

  final LoginHandler loginHandler = LoginHandler();

  //
  final PointsHandler pointsHandler = PointsHandler();
  final PointsCallback pointsCallback = PointsCallback();

  @override
  Widget build(BuildContext context) {
    LoginModel? currentUser = loginHandler.getCurrentUser(context);
    Points? currentPoints = pointsHandler.getCurrentUserPoints(context);
    return GestureDetector(
      onTap: () {
        pointsCallback.onUserPointsTap(context, currentPoints);
      },
      child: Container(
        color: canvasColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, top: 1.0, bottom: 1.0),
          child: Row(
            children: [
              PalladioText(
                currentUser?.name ?? "No user",
                textAlign: TextAlign.center,
                type: PTextType.h3,
                bold: true,
              ),
              PalladioText(" ${currentPoints?.totalPoints ?? "0"} Punti",
                  type: PTextType.h3),
            ],
          ),
        ),
      ),
    );
  }
}
