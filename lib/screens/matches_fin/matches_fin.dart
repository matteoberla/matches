import 'package:flutter/material.dart';
import 'package:matches/components/matches_components/match_fin_day_group.dart';
import 'package:matches/components/matches_components/match_fin_tile.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_callback.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MatchesFinPage extends StatefulWidget {
  const MatchesFinPage({super.key});

  @override
  State<MatchesFinPage> createState() => _MatchesFinPageState();
}

class _MatchesFinPageState extends State<MatchesFinPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  MatchesFinCallback matchesFinCallback = MatchesFinCallback();
  LoginHandler loginHandler = LoginHandler();

  @override
  Widget build(BuildContext context) {
    var matchesFinProvider =
        Provider.of<MatchesFinProvider>(context, listen: true);

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Fase finale",
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
              elements: matchesFinProvider.matchesList,
              groupBy: (element) =>
                  DateTimeHandler.getFormattedDateForAPI(
                      element.date, DateFormatType.date) ??
                  "Mai",
              stickyHeaderBackgroundColor: transparent,
              groupComparator: (g1, g2) {
                return DateTime.parse(g1).compareTo(DateTime.parse(g2));
              },
              groupSeparatorBuilder: (dynamic element) =>
                  MatchFinDayGroup(match: element),
              itemBuilder: (context, dynamic element) =>
                  MatchFinTile(match: element),
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
              matchesFinCallback.onAddMatch(context, matchesFinProvider);
            },
          ),
        ),
      ),
    );
  }
}
