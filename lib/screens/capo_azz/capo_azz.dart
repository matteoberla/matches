import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_boolean_widget.dart';
import 'package:matches/controllers/capo_azz_handlers/capo_azz_callback.dart';
import 'package:matches/controllers/capo_azz_handlers/capo_azz_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/controllers/text_controller_handler.dart';
import 'package:matches/models/capo_azz_models/capo_azz_bet_model.dart';
import 'package:matches/state_management/capo_azz_provider/capo_azz_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class CapoAzzPage extends StatefulWidget {
  const CapoAzzPage({super.key});

  @override
  State<CapoAzzPage> createState() => _CapoAzzPageState();
}

class _CapoAzzPageState extends State<CapoAzzPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  CapoAzzCallback capoAzzCallback = CapoAzzCallback();
  CapoAzzHandler capoAzzHandler = CapoAzzHandler();

  @override
  Widget build(BuildContext context) {
    var capoAzzProvider = Provider.of<CapoAzzProvider>(context, listen: true);

    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Capocannoniere azzurro",
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            setupCallback.onMenuPressed(context, _key);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: PalladioBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: capoAzzProvider.showUsersBetList == false,
                child: Column(
                  children: [
                    const PalladioText(
                      "1 nome",
                      type: PTextType.h2,
                      bold: true,
                    ),
                    PalladioTextInput(
                      textController:
                          capoAzzProvider.capoAzzBetList?[0].betController ??
                              TextEditingController(),
                      allowedChars: AllowedChars.text,
                      textAlign: TextAlign.start,
                      onTap: () {
                        TextControllerHandler.moveCursorToEnd(
                            capoAzzProvider.capoAzzBetList?[0].betController);
                      },
                    ),
                    const EmptySpace(
                      height: 5,
                    ),
                    const PalladioText(
                      "2 nome",
                      type: PTextType.h2,
                      bold: true,
                    ),
                    PalladioTextInput(
                      textController:
                          capoAzzProvider.capoAzzBetList?[1].betController ??
                              TextEditingController(),
                      allowedChars: AllowedChars.text,
                      textAlign: TextAlign.start,
                      onTap: () {
                        TextControllerHandler.moveCursorToEnd(
                            capoAzzProvider.capoAzzBetList?[1].betController);
                      },
                    ),
                    const EmptySpace(
                      height: 10,
                    ),
                    Row(
                      children: [
                        PalladioActionButton(
                          title: "Salva",
                          onTap: () async {
                            capoAzzCallback.onSavePressed(
                                context, capoAzzProvider);
                          },
                          backgroundColor: interactiveColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  PalladioActionButton(
                    title: capoAzzProvider.showUsersBetList
                        ? "Indietro"
                        : "Imposta risultato",
                    onTap: () async {
                      capoAzzCallback
                          .onImpostaRisultatoPressed(capoAzzProvider);
                    },
                    backgroundColor: interactiveColor,
                  ),
                ],
              ),
              Visibility(
                visible: capoAzzProvider.showUsersBetList,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: capoAzzProvider.usersCapoAzzBetListLength,
                    itemBuilder: (context, index) {
                      CapoAzzBet userBet =
                          capoAzzProvider.usersCapoAzzBetList[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PalladioText(userBet.value ?? "???",
                              type: PTextType.h3),
                          TypedBooleanWidget(
                              onPressed: () {
                                capoAzzCallback.onBetValidityChanged(
                                    context, capoAzzProvider, userBet);
                              },
                              status: userBet.isValid == 1),
                          PalladioText("Punti: ${userBet.points ?? "???"}",
                              type: PTextType.h3),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: PalladioDrawer(
        drawerKey: _key,
      ),
    );
  }
}
