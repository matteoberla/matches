import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/teams_models/teams_model.dart';

class TeamFlagName extends StatelessWidget {
  const TeamFlagName(
      {super.key,
      required this.team,
      this.nameOnLeft = false,
      this.align = MainAxisAlignment.center});

  final Teams? team;
  final bool nameOnLeft;
  final MainAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: align,
        children: [
          if (nameOnLeft)
            PalladioText(
              team?.breve ?? "???",
              type: PTextType.h2,
              bold: true,
              maxLines: 1,
            ),
          if (nameOnLeft)
            const EmptySpace(
              width: 10,
            ),
          TeamsHandler.getTeamFlag(team?.iso),
          if (!nameOnLeft)
            const EmptySpace(
              width: 10,
            ),
          if (!nameOnLeft)
            PalladioText(
              team?.breve ?? "???",
              type: PTextType.h2,
              bold: true,
              maxLines: 1,
            ),
        ],
      ),
    );
  }
}
