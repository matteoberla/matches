import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/styles.dart';

class MatchFinDayGroup extends StatelessWidget {
  const MatchFinDayGroup({super.key, required this.match});

  final Matches match;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: interactiveColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
              child: PalladioText(
                DateTimeHandler.getFormattedDateFromString(
                        match.date, DateFormatType.monthExtended) ??
                    "Mai",
                type: PTextType.h2,
                bold: true,
                textColor: lightTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
