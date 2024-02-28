import 'package:flutter/material.dart';
import 'package:matches/controllers/gironi_handlers/gironi_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class GironeTile extends StatelessWidget {
  GironeTile({super.key, required this.girone, this.activeActions = true});

  final Gironi girone;
  final TeamsHandler teamsHandler = TeamsHandler();
  final GironiHandler gironiHandler = GironiHandler();
  final bool activeActions;

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: true);
    var gironiProvider = Provider.of<GironiProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AbsorbPointer(
                absorbing: !activeActions,
                child: gironiHandler.getGironeTile(
                    context, teamsProvider, gironiProvider, girone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
