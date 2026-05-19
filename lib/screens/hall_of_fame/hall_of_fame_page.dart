import 'package:flutter/material.dart';
import 'package:matches/components/crediti_components/crediti_timeline.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/timeline_components/classifica_card.dart';
import 'package:matches/components/timeline_components/descriptive_card.dart';
import 'package:matches/components/timeline_components/icon_indicator.dart';
import 'package:matches/components/timeline_components/loading_indicator.dart';
import 'package:matches/components/timeline_components/trophy_indicator.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/models/timeline_models/classifiche_lists.dart';
import 'package:matches/models/timeline_models/timeline_data.dart';
import 'package:matches/styles.dart';

class HallOfFamePage extends StatefulWidget {
  const HallOfFamePage({super.key});

  @override
  State<HallOfFamePage> createState() => _HallOfFamePageState();
}

class _HallOfFamePageState extends State<HallOfFamePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final SetupCallback setupCallback = SetupCallback();

  List<TimelineData> nodes = [
    const TimelineData(
      indicator:
          IconIndicator(icon: Icons.military_tech, color: Colors.blueAccent),
      content: DescriptiveCard(
        title: 'I campioni del passato',
        description:
            'Le leggende prima o poi ci abbandoneranno (🤘🏼), ma i loro punteggi resteranno scolpiti per sempre... nello schermo.',
      ),
    ),
    const TimelineData(
      indicator: TrophyIndicator(),
      content: ClassificaCard(
        entries: classificaEu2016,
        title: 'Classifica Europei 2016',
      ),
    ),
    const TimelineData(
      indicator: TrophyIndicator(),
      content: ClassificaCard(
        entries: classificaMo2018,
        title: 'Classifica Mondiali 2018',
      ),
    ),
    const TimelineData(
      indicator: TrophyIndicator(),
      content: ClassificaCard(
        entries: classificaEu2020,
        title: 'Classifica Europei 2020/2021',
      ),
    ),
    const TimelineData(
      indicator: TrophyIndicator(),
      content: ClassificaCard(
        entries: classificaMo2022,
        title: 'Classifica Mondiali 2022',
      ),
    ),
    const TimelineData(
      indicator: TrophyIndicator(),
      content: ClassificaCard(
        entries: classificaEu2024,
        title: 'Classifica Europei 2024',
      ),
    ),
    const TimelineData(
      indicator: LoadingIndicator(),
      content: ClassificaCard(
        entries: classificaMo2026,
        title: 'Classifica Mondiali 2026',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Hall Of Fame",
          backgroundColor: canvasColor,
          leading: IconButton(
            onPressed: () => setupCallback.onMenuPressed(context, _key),
            icon: const Icon(Icons.menu),
          ),
        ),
        body: PalladioBody(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: CustomTimeline(
                nodes: nodes,
              ),
            ),
          ),
        ),
        drawer: PalladioDrawer(drawerKey: _key),
      ),
    );
  }
}
