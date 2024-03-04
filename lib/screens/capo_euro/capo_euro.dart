import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';
import 'package:matches/components/typed_widgets_components/typed_boolean_widget.dart';
import 'package:matches/controllers/capo_euro_handlers/capo_euro_callback.dart';
import 'package:matches/controllers/capo_euro_handlers/capo_euro_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/controllers/text_controller_handler.dart';
import 'package:matches/models/capo_euro_models/capo_euro_bet_model.dart';
import 'package:matches/state_management/capo_euro_provider/capo_euro_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class CapoEuroPage extends StatefulWidget {
  const CapoEuroPage({super.key});

  @override
  State<CapoEuroPage> createState() => _CapoEuroPageState();
}

class _CapoEuroPageState extends State<CapoEuroPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  LoginHandler loginHandler = LoginHandler();
  CapoEuroCallback capoEuroCallback = CapoEuroCallback();
  CapoEuroHandler capoEuroHandler = CapoEuroHandler();

  @override
  Widget build(BuildContext context) {
    var capoEuroProvider = Provider.of<CapoEuroProvider>(context, listen: true);

    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Capocannoniere europeo",
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: capoEuroProvider.showUsersBetList == false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PalladioText(
                        "1 nome",
                        type: PTextType.h2,
                        bold: true,
                      ),
                      PalladioTextInput(
                        textController: capoEuroProvider
                                .capoEuroBetList?[0].betController ??
                            TextEditingController(),
                        allowedChars: AllowedChars.text,
                        textAlign: TextAlign.start,
                        onTap: () {
                          TextControllerHandler.moveCursorToEnd(capoEuroProvider
                              .capoEuroBetList?[0].betController);
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
                        textController: capoEuroProvider
                                .capoEuroBetList?[1].betController ??
                            TextEditingController(),
                        allowedChars: AllowedChars.text,
                        textAlign: TextAlign.start,
                        onTap: () {
                          TextControllerHandler.moveCursorToEnd(capoEuroProvider
                              .capoEuroBetList?[1].betController);
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
                              capoEuroCallback.onSavePressed(
                                  context, capoEuroProvider);
                            },
                            backgroundColor: interactiveColor,
                          ),
                        ],
                      ),
                      const EmptySpace(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: loginHandler.currentUserIsAdmin(context),
                  child: Row(
                    children: [
                      PalladioActionButton(
                        title: capoEuroProvider.showUsersBetList
                            ? "Indietro"
                            : "Imposta risultato",
                        onTap: () async {
                          capoEuroCallback
                              .onImpostaRisultatoPressed(capoEuroProvider);
                        },
                        backgroundColor: interactiveColor,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: capoEuroProvider.showUsersBetList,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: capoEuroProvider.usersCapoEuroBetListLength,
                      itemBuilder: (context, index) {
                        CapoEuroBet userBet =
                            capoEuroProvider.usersCapoEuroBetList[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PalladioText(userBet.value ?? "???",
                                type: PTextType.h3),
                            TypedBooleanWidget(
                                onPressed: () {
                                  capoEuroCallback.onBetValidityChanged(
                                      context, capoEuroProvider, userBet);
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
      ),
      drawer: PalladioDrawer(
        drawerKey: _key,
      ),
    );
  }
}
