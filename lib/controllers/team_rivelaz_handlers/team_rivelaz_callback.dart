import 'package:flutter/material.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/team_rivelaz_handlers/team_rivelaz_handler.dart';
import 'package:matches/state_management/team_rivelaz_provider/team_rivelaz_provider.dart';

class TeamRivelazCallback {
  onTeamBetPressed(BuildContext context, TeamRivelazProvider provider) async {
    TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
    await teamRivelazHandler.editTeamBet(context, provider);
  }

  onTeamPressed(BuildContext context, TeamRivelazProvider provider) async {
    TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
    await teamRivelazHandler.editTeam(context, provider);
  }

  onSaveBetPressed(BuildContext context, TeamRivelazProvider provider) async {
    TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
    await teamRivelazHandler.verifyTeamRivelazBet(context, provider);
  }

  onSavePressed(BuildContext context, TeamRivelazProvider provider) async {
    LoginHandler loginHandler = LoginHandler();
    bool editable = await loginHandler.resultCanBeEdited(context);

    if (editable && context.mounted) {
      TeamRivelazHandler teamRivelazHandler = TeamRivelazHandler();
      await teamRivelazHandler.verifyTeamRivelaz(context, provider);
    }
  }

  onImpostaRisultatoPressed(
      BuildContext context, TeamRivelazProvider provider) {
    provider.updateShowFinalResult();
  }
}
