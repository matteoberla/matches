import 'package:flutter/material.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/persistent_data_handlers/login_shared_preferences.dart';

class SetupCallback {
  onMenuPressed(BuildContext context, GlobalKey<ScaffoldState> drawerKey) {
    drawerKey.currentState!.openDrawer();
  }

  onPartitePressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/matches');
  }

  onGironiPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/gironi');
  }

  onPartiteFinaliPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/matches_fin');
  }

  onGoalVelocePressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/goal_veloce');
  }

  onTeamRivelazPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/team_rivelaz');
  }

  onCapocannoniereEuroPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/capo_euro');
  }

  onCapocannoniereItaPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/capo_azz');
  }

  onSquadrePressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/teams_list');
  }

  onClassificaPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/points_list');
  }

  onLogoutPressed(BuildContext context) async {
    await Alerts.showConfirmAlertNoContext("Conferma", "Eseguire il logout?",
        () {
      LoginSharedPreferences.saveLoginCredentials(null, null);
      LoginSharedPreferences.saveAccessInformation(null);
      Navigator.pushReplacementNamed(context, '/login');
    }, () {
      Navigator.of(context).pop();
    });
  }
}
