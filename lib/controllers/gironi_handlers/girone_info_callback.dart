import 'package:flutter/material.dart';
import 'package:matches/controllers/gironi_handlers/girone_info_handler.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';

class GironeInfoCallback {
  onTeam1Pressed(BuildContext context, GironiProvider provider) async {
    GironeInfoHandler gironeInfoHandler = GironeInfoHandler();
    await gironeInfoHandler.editTeam1(context, provider);
  }

  onTeam2Pressed(BuildContext context, GironiProvider provider) async {
    GironeInfoHandler gironeInfoHandler = GironeInfoHandler();
    await gironeInfoHandler.editTeam2(context, provider);
  }

  onTeam3Pressed(BuildContext context, GironiProvider provider) async {
    GironeInfoHandler gironeInfoHandler = GironeInfoHandler();
    await gironeInfoHandler.editTeam3(context, provider);
  }

  onTeam4Pressed(BuildContext context, GironiProvider provider) async {
    GironeInfoHandler gironeInfoHandler = GironeInfoHandler();
    await gironeInfoHandler.editTeam4(context, provider);
  }

  onSaveGirone(BuildContext context, GironiProvider provider) async {
    GironeInfoHandler gironeInfoHandler = GironeInfoHandler();
    await gironeInfoHandler.verifyGirone(context, provider);
  }
}
