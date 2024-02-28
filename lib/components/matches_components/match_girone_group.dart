import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/styles.dart';

class MatchGironeGroup extends StatelessWidget {
  MatchGironeGroup({super.key, required this.match});

  final Matches match;
  final MatchesHandler matchesHandler = MatchesHandler();

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
                matchesHandler.getMatchGroup(context, match),
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
