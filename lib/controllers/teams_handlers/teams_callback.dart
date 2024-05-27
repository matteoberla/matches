import 'package:flutter/cupertino.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/main.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';

class TeamsCallback {
  onTeamTap(BuildContext context, TeamsProvider provider, Teams team) {
    //inizializzazione campi
    team.nameController.text = team.name ?? "";
    team.isoController.text = team.iso ?? "";
    team.gironeController.text = team.girone ?? "";
    //
    provider.updateSelectedTeam(team);
    Navigator.pushNamed(context, "/team_info");
  }

  onTeamTileLongPress(
    BuildContext context,
    TeamsProvider provider,
    Teams team,
  ) async {
    LoginHandler loginHandler = LoginHandler();
    if (loginHandler.currentUserIsAdminOrImpersona(context) == false) return;
    await Alerts.showConfirmAlertNoContext("Conferma", "Eliminare la squadra?",
        () async {
      //eliminazione
      Navigator.of(navigatorKey.currentContext!).pop();
      TeamsHandler teamsHandler = TeamsHandler();
      await teamsHandler.deleteTeam(context, provider, team);
    }, () {
      Navigator.pop(context);
    });
  }

  onAddTeam(BuildContext context, TeamsProvider provider) {
    Teams newTeam = Teams();
    provider.updateSelectedTeam(newTeam);
    Navigator.pushNamed(context, "/team_info");
  }

  onTeamSaved(BuildContext context, TeamsProvider provider) async {
    TeamsHandler teamsHandler = TeamsHandler();
    await teamsHandler.verifyTeam(context, provider);
  }
}
