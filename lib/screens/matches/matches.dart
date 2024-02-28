import 'package:flutter/material.dart';
import 'package:matches/components/matches_components/match_girone_group.dart';
import 'package:matches/components/matches_components/match_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_callback.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  MatchesCallback matchesCallback = MatchesCallback();
  LoginHandler loginHandler = LoginHandler();
  MatchesHandler matchesHandler = MatchesHandler();

  @override
  Widget build(BuildContext context) {
    var matchesProvider = Provider.of<MatchesProvider>(context, listen: true);

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Fase a gironi",
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
              elements: matchesProvider.matchesList,
              groupBy: (element) =>
                  matchesHandler.getMatchGroup(context, element),
              stickyHeaderBackgroundColor: transparent,
              groupComparator: (g1, g2) {
                return g1.compareTo(g2);
              },
              groupSeparatorBuilder: (dynamic element) =>
                  MatchGironeGroup(match: element),
              itemBuilder: (context, dynamic element) =>
                  MatchTile(match: element),
              itemComparator: (e1, e2) =>
                  (DateTimeHandler.getDateTimeFromString(
                              e1.date, DateFormatType.dateAndTime) ??
                          DateTime.now())
                      .compareTo(DateTimeHandler.getDateTimeFromString(
                              e2.date, DateFormatType.dateAndTime) ??
                          DateTime.now()),
              elementIdentifier: (element) => element.name),
        ),
        drawer: PalladioDrawer(
          drawerKey: _key,
        ),
        floatingActionButton: Visibility(
          visible: loginHandler.currentUserIsAdmin(context),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              matchesCallback.onAddMatch(context, matchesProvider);
            },
          ),
        ),
      ),
    );
  }
}
