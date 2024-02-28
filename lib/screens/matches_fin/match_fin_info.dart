import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_responsive_form_field.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/components/typed_widgets_components/typed_input_text_widget.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/match_fin_info_callback.dart';
import 'package:matches/controllers/matches_fin_handlers/match_fin_info_handler.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class MatchFinInfoPage extends StatefulWidget {
  const MatchFinInfoPage({super.key});

  @override
  State<MatchFinInfoPage> createState() => _MatchFinInfoPageState();
}

class _MatchFinInfoPageState extends State<MatchFinInfoPage> {
  MatchFinInfoCallback matchFinInfoCallback = MatchFinInfoCallback();
  MatchFinInfoHandler matchFinInfoHandler = MatchFinInfoHandler();

  @override
  Widget build(BuildContext context) {
    var matchesFinProvider =
        Provider.of<MatchesFinProvider>(context, listen: true);
    Matches? selectedMatch = matchesFinProvider.selectedMatch;

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
                          await matchFinInfoCallback.onDataPressed(
                              context, matchesFinProvider);
                        },
                      ),
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Fase",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: matchFinInfoHandler.getFaseDescFromId(
                                context, selectedMatch?.fase) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await matchFinInfoCallback.onFasePressed(
                              context, matchesFinProvider);
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
                    fieldTitle: "Descrizione 1",
                    formField: TypedTextInputWidget(
                      textController: selectedMatch?.des1Controller ??
                          TextEditingController(),
                      allowedChars: AllowedChars.text,
                      textAlign: TextAlign.start,
                      onChanged: (newText) {},
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Descrizione 2",
                    formField: TypedTextInputWidget(
                      textController: selectedMatch?.des2Controller ??
                          TextEditingController(),
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
                    fieldTitle: "Numero partita",
                    formField: TypedTextInputWidget(
                      textController: selectedMatch?.nMatchController ??
                          TextEditingController(),
                      allowedChars: AllowedChars.integer,
                      textAlign: TextAlign.start,
                      onChanged: (newText) {},
                    ),
                  ),
                ],
              ),
              PalladioRowActionButtons(onSave: () async {
                await matchFinInfoCallback.onSaveMatch(
                    context, matchesFinProvider);
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
