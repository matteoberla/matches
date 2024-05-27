import 'package:flutter/material.dart';
import 'package:matches/components/gironi_components/girone_group.dart';
import 'package:matches/components/gironi_components/girone_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/controllers/gironi_handlers/gironi_callback.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class GironiPage extends StatefulWidget {
  const GironiPage({super.key});

  @override
  State<GironiPage> createState() => _GironiPageState();
}

class _GironiPageState extends State<GironiPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  LoginHandler loginHandler = LoginHandler();
  GironiCallback gironiCallback = GironiCallback();

  @override
  Widget build(BuildContext context) {
    var gironiProvider = Provider.of<GironiProvider>(context, listen: true);

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Classifica gironi",
          backgroundColor: canvasColor,
          leading: IconButton(
            onPressed: () {
              setupCallback.onMenuPressed(context, _key);
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        body: PalladioBody(
          child: StickyGroupedListView<dynamic, String>(
              elements: gironiProvider.gironiList,
              groupBy: (element) => element.girone,
              stickyHeaderBackgroundColor: transparent,
              groupComparator: (g1, g2) {
                return g1.compareTo(g2);
              },
              groupSeparatorBuilder: (dynamic element) =>
                  GironeGroup(girone: element),
              itemBuilder: (context, dynamic element) => GironeTile(
                    girone: element,
                    activeActions: true,
                  ),
              itemComparator: (e1, e2) => e1.id.compareTo(e2.id),
              elementIdentifier: (element) => element.name),
        ),
        drawer: PalladioDrawer(
          drawerKey: _key,
        ),
        floatingActionButton: Visibility(
          visible: loginHandler.currentUserIsAdminOrImpersona(context),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              gironiCallback.onAddGirone(context, gironiProvider);
            },
          ),
        ),
      ),
    );
  }
}
