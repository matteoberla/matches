import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_responsive_form_field.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/matches_handlers/match_info_callback.dart';
import 'package:matches/controllers/matches_handlers/match_info_handler.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class MatchInfoPage extends StatefulWidget {
  const MatchInfoPage({super.key});

  @override
  State<MatchInfoPage> createState() => _MatchInfoPageState();
}

class _MatchInfoPageState extends State<MatchInfoPage> {
  MatchInfoCallback matchInfoCallback = MatchInfoCallback();
  MatchInfoHandler matchInfoHandler = MatchInfoHandler();

  @override
  Widget build(BuildContext context) {
    var matchesProvider = Provider.of<MatchesProvider>(context, listen: true);
    Matches? selectedMatch = matchesProvider.selectedMatch;

    return Scaffold(
      appBar: PalladioAppBar(
        title: "${selectedMatch?.id == null ? "Nuova" : "Modifica"} Partita",
        backgroundColor: canvasColor,
      ),
      body: PalladioBody(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ResponsiveRow(
                columnsCount: 100,
                children: [
                  PalladioResponsiveFormField(
                    fieldTitle: "Data",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue:
                            DateTimeHandler.getFormattedDateFromString(
                                    selectedMatch?.date,
                                    DateFormatType.dateAndTime) ??
                                "Nessuna data",
                        onPressed: () async {
                          await matchInfoCallback.onDataPressed(
                              context, matchesProvider);
                        },
                      ),
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Fase",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: matchInfoHandler.getFaseDescFromId(
                                context, selectedMatch?.fase) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await matchInfoCallback.onFasePressed(
                              context, matchesProvider);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ResponsiveRow(
                columnsCount: 100,
                children: [
                  PalladioResponsiveFormField(
                    fieldTitle: "Squadra 1",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: matchInfoHandler.getTeamDescFromId(
                                context, selectedMatch?.idTeam1) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await matchInfoCallback.onTeam1Pressed(
                              context, matchesProvider);
                        },
                      ),
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Squadra 2",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: matchInfoHandler.getTeamDescFromId(
                                context, selectedMatch?.idTeam2) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await matchInfoCallback.onTeam2Pressed(
                              context, matchesProvider);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              PalladioRowActionButtons(onSave: () async {
                await matchInfoCallback.onSaveMatch(context, matchesProvider);
              }, onExit: () {
                Navigator.of(context).pop();
              })
            ],
          ),
        ),
      ),
    );
  }
}
