import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/controllers/teams_handlers/teams_callback.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class TeamsListPage extends StatefulWidget {
  const TeamsListPage({super.key});

  @override
  State<TeamsListPage> createState() => _TeamsListPageState();
}

class _TeamsListPageState extends State<TeamsListPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  TeamsCallback teamsCallback = TeamsCallback();

  //
  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: true);
    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Squadre",
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            setupCallback.onMenuPressed(context, _key);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: PalladioBody(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: teamsProvider.teamsListLength,
          itemBuilder: (context, index) {
            Teams team = teamsProvider.teamsList[index];

            return ListTile(
              leading: TeamsHandler.getTeamFlag(team.iso),
              title: PalladioText(
                team.name ?? "",
                type: PTextType.h2,
              ),
              subtitle: PalladioText(
                team.girone ?? "",
                type: PTextType.h3,
                textColor: opaqueTextColor,
              ),
              onTap: () {
                teamsCallback.onTeamTap(context, teamsProvider, team);
              },
              onLongPress: () {
                teamsCallback.onTeamTileLongPress(context, teamsProvider, team);
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      ),
      drawer: PalladioDrawer(
        drawerKey: _key,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          teamsCallback.onAddTeam(context, teamsProvider);
        },
      ),
    );
  }
}
