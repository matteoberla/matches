import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/points_components/points_row.dart';
import 'package:matches/components/typed_widgets_components/typed_boolean_widget.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_callback.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/styles.dart';

class PointsBottomSheetHandler {
  openPointsBottomSheet(BuildContext context, Points userPoints) async {
    LoginHandler loginHandler = LoginHandler();
    PointsCallback pointsCallback = PointsCallback();

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (pointsContext) {
        return Padding(
          padding: EdgeInsets.only(
              top: AppBar().preferredSize.height, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Scaffold(
              body: PalladioBody(
                showBottomBar: false,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PalladioText(
                          userPoints.username ?? "",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        PointsRow(
                          description: "Totale:",
                          points: userPoints.totalPoints,
                          boldDescription: true,
                        ),
                        const Divider(),
                        PointsRow(
                          description: "Fase a gironi:",
                          points: userPoints.totalMatchesPoints,
                        ),
                        PointsRow(
                          description: "Gironi:",
                          points: userPoints.totalGironiPoints,
                        ),
                        PointsRow(
                          description: "Fase finale:",
                          points: userPoints.totalMatchesFinPoints,
                        ),
                        PointsRow(
                          description: "Bonus quartifinaliste:",
                          points: userPoints.totalMatchesFinBonusQuarti,
                        ),
                        PointsRow(
                          description: "Bonus semifinaliste:",
                          points: userPoints.totalMatchesFinBonusSemi,
                        ),
                        PointsRow(
                          description: "Bonus finaliste:",
                          points: userPoints.totalMatchesFinBonusFinal,
                        ),
                        PointsRow(
                          description: "Goal veloce:",
                          points: userPoints.totalGoalVelocePoints,
                        ),
                        PointsRow(
                          description: "Team rivelazione:",
                          points: userPoints.totalTeamRivelazPoints,
                        ),
                        PointsRow(
                          description: "Capocannoniere azzurro:",
                          points: userPoints.totalCapoAzzPoints,
                        ),
                        PointsRow(
                          description: "Capocannoniere europeo:",
                          points: userPoints.totalCapoEuroPoints,
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        Visibility(
                          visible: loginHandler.currentUserIsAdmin(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const PalladioText(
                                "Utente attivo:",
                                type: PTextType.h2,
                                bold: true,
                              ),
                              TypedBooleanWidget(
                                  onPressed: () async {
                                    await pointsCallback.onToggleUserStatus(
                                        pointsContext, userPoints);
                                  },
                                  status: userPoints.isActive == 1),
                            ],
                          ),
                        ),
                        const EmptySpace(
                          height: 10,
                        ),
                        Row(
                          children: [
                            PalladioActionButton(
                              title: "Esci",
                              onTap: () {
                                Navigator.of(pointsContext).pop();
                              },
                              backgroundColor: dangerColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
