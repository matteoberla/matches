import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/palladio_std_components/palladio_text_span.dart';
import 'package:matches/components/team_components/team_flag_name.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/models/teams_models/teams_model.dart';

class GironePosRow extends StatelessWidget {
  GironePosRow({
    super.key,
    required this.team,
    required this.posController,
    this.pt,
    this.gf,
    this.gs,
  });

  final Teams? team;
  final TextEditingController? posController;
  final String? pt;
  final String? gf;
  final String? gs;

  final LoginHandler loginHandler = LoginHandler();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
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
                  readOnly:
                      !loginHandler.currentUserIsAdminOrImpersona(context),
                  enabled: loginHandler.currentUserIsAdminOrImpersona(context),
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                if (pt != null)
                  const PalladioTextSpan("Pt: ", type: PTextType.h3, bold: true)
                      .getTextSpan(),
                if (pt != null)
                  PalladioTextSpan(
                    pt ?? "???",
                    type: PTextType.h3,
                  ).getTextSpan(),
                if (gf != null)
                  const PalladioTextSpan("  GF: ",
                          type: PTextType.h3, bold: true)
                      .getTextSpan(),
                if (gf != null)
                  PalladioTextSpan(
                    gf ?? "???",
                    type: PTextType.h3,
                  ).getTextSpan(),
                if (gs != null)
                  const PalladioTextSpan("  GS: ",
                          type: PTextType.h3, bold: true)
                      .getTextSpan(),
                if (gs != null)
                  PalladioTextSpan(
                    gs ?? "???",
                    type: PTextType.h3,
                  ).getTextSpan(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
