import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_responsive_form_field.dart';
import 'package:matches/components/palladio_std_components/palladio_row_actions_buttons.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_action_button_widget.dart';
import 'package:matches/components/typed_widgets_components/typed_input_text_widget.dart';
import 'package:matches/controllers/gironi_handlers/girone_info_callback.dart';
import 'package:matches/controllers/gironi_handlers/girone_info_handler.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class GironeInfoPage extends StatefulWidget {
  const GironeInfoPage({super.key});

  @override
  State<GironeInfoPage> createState() => _GironeInfoPageState();
}

class _GironeInfoPageState extends State<GironeInfoPage> {
  GironeInfoCallback gironeInfoCallback = GironeInfoCallback();
  GironeInfoHandler gironeInfoHandler = GironeInfoHandler();

  @override
  Widget build(BuildContext context) {
    var gironiProvider = Provider.of<GironiProvider>(context, listen: true);
    Gironi? selectedGirone = gironiProvider.selectedGirone;

    return Scaffold(
      appBar: PalladioAppBar(
        title: "${selectedGirone?.id == null ? "Nuovo" : "Modifica"} Girone",
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
                    fieldTitle: "Girone",
                    formField: TypedTextInputWidget(
                      textController: selectedGirone?.gironeController ??
                          TextEditingController(),
                      allowedChars: AllowedChars.text,
                      textAlign: TextAlign.start,
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
                        displayedValue: gironeInfoHandler.getTeamDescFromId(
                                context, selectedGirone?.idTeam1) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await gironeInfoCallback.onTeam1Pressed(
                              context, gironiProvider);
                        },
                      ),
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Squadra 2",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: gironeInfoHandler.getTeamDescFromId(
                                context, selectedGirone?.idTeam2) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await gironeInfoCallback.onTeam2Pressed(
                              context, gironiProvider);
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
                    fieldTitle: "Squadra 3",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: gironeInfoHandler.getTeamDescFromId(
                                context, selectedGirone?.idTeam3) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await gironeInfoCallback.onTeam3Pressed(
                              context, gironiProvider);
                        },
                      ),
                    ),
                  ),
                  PalladioResponsiveFormField(
                    fieldTitle: "Squadra 4",
                    formField: SizedBox(
                      width: double.infinity,
                      child: TypedActionButtonWidget(
                        displayedValue: gironeInfoHandler.getTeamDescFromId(
                                context, selectedGirone?.idTeam4) ??
                            "Nessuna selezione",
                        onPressed: () async {
                          await gironeInfoCallback.onTeam4Pressed(
                              context, gironiProvider);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              PalladioRowActionButtons(onSave: () async {
                await gironeInfoCallback.onSaveGirone(context, gironiProvider);
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
