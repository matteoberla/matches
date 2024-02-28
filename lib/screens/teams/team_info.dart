import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_responsive_form_field.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_input_text_widget.dart';
import 'package:matches/controllers/teams_handlers/teams_callback.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({super.key});

  @override
  State<TeamInfoPage> createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {
  TeamsCallback teamsCallback = TeamsCallback();

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: true);

    Teams? selectedTeam = teamsProvider.selectedTeam;

    return Scaffold(
      appBar: PalladioAppBar(
        title: "${selectedTeam?.id == null ? "Nuova" : "Modifica"} Squadra",
        backgroundColor: canvasColor,
      ),
      body: PalladioBody(
        child: Column(
          children: [
            ResponsiveRow(
              columnsCount: 100,
              children: [
                PalladioResponsiveFormField(
                  fieldTitle: "Nome",
                  formField: TypedTextInputWidget(
                    textController:
                        selectedTeam?.nameController ?? TextEditingController(),
                    allowedChars: AllowedChars.text,
                    textAlign: TextAlign.start,
                    onChanged: (newText) {},
                  ),
                ),
                PalladioResponsiveFormField(
                  fieldTitle: "Iso",
                  formField: TypedTextInputWidget(
                    textController:
                        selectedTeam?.isoController ?? TextEditingController(),
                    allowedChars: AllowedChars.text,
                    textAlign: TextAlign.start,
                    onChanged: (newText) {},
                  ),
                ),
              ],
            ),
            ResponsiveRow(
              columnsCount: 100,
              children: [
                PalladioResponsiveFormField(
                  fieldTitle: "Girone",
                  formField: TypedTextInputWidget(
                    textController: selectedTeam?.gironeController ??
                        TextEditingController(),
                    allowedChars: AllowedChars.text,
                    textAlign: TextAlign.start,
                    onChanged: (newText) {},
                  ),
                ),
              ],
            ),
            PalladioRowActionButtons(onSave: () async {
              await teamsCallback.onTeamSaved(context, teamsProvider);
            }, onExit: () {
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }
}
