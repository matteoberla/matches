import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_asset_image.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/models/login_models/login_model.dart';

class PalladioDrawer extends StatelessWidget {
  PalladioDrawer({super.key, required this.drawerKey});

  final GlobalKey<ScaffoldState> drawerKey;

  final SetupCallback setupCallback = SetupCallback();

  @override
  Widget build(BuildContext context) {
    LoginHandler loginHandler = LoginHandler();
    LoginModel? currentUser = loginHandler.getCurrentUser(context);
    //
    PointsHandler pointsHandler = PointsHandler();

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PalladioText(
                      currentUser?.name ?? "No user",
                      textAlign: TextAlign.center,
                      type: PTextType.h1,
                      bold: true,
                    ),
                    PalladioText(
                        "${pointsHandler.getCurrentUserPoints(context)?.totalPoints ?? "0"} Punti",
                        type: PTextType.h3),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    drawerKey.currentState?.closeDrawer();
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Fase a gironi",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onPartitePressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "gironi.png",
                    ),
                    title: const PalladioText(
                      "Classifica gironi",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onGironiPressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Fase finale",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onPartiteFinaliPressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Goal veloce",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onGoalVelocePressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Team rivelazione",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onTeamRivelazPressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Capocannoniere Euro",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onCapocannoniereEuroPressed(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const PalladioAssetImage(
                      directory: "general",
                      fileName: "matches.png",
                    ),
                    title: const PalladioText(
                      "Capocannoniere Azzurro",
                      type: PTextType.h3,
                    ),
                    onTap: () async {
                      setupCallback.onCapocannoniereItaPressed(context);
                    },
                  ),
                  if (loginHandler.currentUserIsAdmin(context)) const Divider(),
                  if (loginHandler.currentUserIsAdmin(context))
                    ListTile(
                      leading: const PalladioAssetImage(
                        directory: "general",
                        fileName: "squadre.png",
                      ),
                      title: const PalladioText(
                        "Squadre",
                        type: PTextType.h3,
                      ),
                      onTap: () async {
                        setupCallback.onSquadrePressed(context);
                      },
                    ),
                  if (loginHandler.currentUserIsAdmin(context)) const Divider(),
                  if (loginHandler.currentUserIsAdmin(context))
                    ListTile(
                      leading: const PalladioAssetImage(
                        directory: "general",
                        fileName: "squadre.png",
                      ),
                      title: const PalladioText(
                        "Classifica",
                        type: PTextType.h3,
                      ),
                      onTap: () async {
                        setupCallback.onClassificaPressed(context);
                      },
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const PalladioAssetImage(
              directory: "general",
              fileName: "settings.png",
            ),
            title: const PalladioText(
              "Logout",
              type: PTextType.h3,
            ),
            onTap: () async {
              setupCallback.onLogoutPressed(context);
            },
          ),
        ],
      ),
    );
  }
}
