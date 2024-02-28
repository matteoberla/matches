import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/team_components/team_flag_name.dart';
import 'package:matches/models/teams_models/teams_model.dart';

class GironePosRow extends StatelessWidget {
  const GironePosRow({
    super.key,
    required this.team,
    required this.posController,
  });

  final Teams? team;
  final TextEditingController? posController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          TeamFlagName(team: team),
          const EmptySpace(
            width: 10,
          ),
          const PalladioText("Pos. finale: ", type: PTextType.h1),
          Expanded(
            child: PalladioTextInput(
              textController: posController ?? TextEditingController(),
              allowedChars: AllowedChars.integer,
            ),
          ),
        ],
      ),
    );
  }
}
