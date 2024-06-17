import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PointsCallback {
  onUserPointsTap(BuildContext context, Points? userPoints) async {
    if (userPoints != null) {
      PointsHandler pointsHandler = PointsHandler();
      await pointsHandler.openPointsBottomSheet(context, userPoints);
    }
  }

  onToggleUserStatus(BuildContext context, Points userPoints) async {
    PointsHandler pointsHandler = PointsHandler();
    bool success = await pointsHandler.toggleUserActive(context, userPoints);

    if (success && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  copyUserPoints(BuildContext context, PointsProvider provider) {
    PointsHandler pointsHandler = PointsHandler();
    Clipboard.setData(
            ClipboardData(text: pointsHandler.getUsersPoints(provider)))
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Classifica salvata negli appunti")));
    });
  }

  impersonaUtente(BuildContext context, Points userPoints) async {
    LoginHandler loginHandler = LoginHandler();

    if (userPoints.userId != null) {
      await loginHandler.impersonaUtente(context, userPoints.userId!);
    }
  }

  onSearchUtente(
      BuildContext context,
      PointsProvider provider,
      TextEditingController textController,
      ItemScrollController scrollController) async {
    String searchedUser = textController.text.toLowerCase();

    //cerco utenti
    int foundIndex = provider.pointsList.indexWhere((element) =>
        (element.nickname ?? "").toLowerCase().contains(searchedUser) ||
        (element.username ?? "").toLowerCase().contains(searchedUser));

    if (foundIndex != -1) {
      scrollController.scrollTo(
          index: foundIndex, duration: const Duration(milliseconds: 250));
    } else {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Nessun utente '$searchedUser' trovato");
    }
  }
}
