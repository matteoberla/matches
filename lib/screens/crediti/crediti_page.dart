import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_asset_image.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/styles.dart';
import 'package:timelines_plus/timelines_plus.dart';

class CreditiPage extends StatefulWidget {
  const CreditiPage({super.key});

  @override
  State<CreditiPage> createState() => _CreditiPageState();
}

const List<ClassificaEntry> classificaEu2024 = [
  ClassificaEntry(pos: 1, nome: 'Fede penzo 325pt', color: Color(0xFFFFD700)),
  ClassificaEntry(pos: 2, nome: 'pigia 316pt', color: Color(0xFFC0C0C0)),
  ClassificaEntry(pos: 3, nome: 'ghei 316pt', color: Color(0xFFCD7F32)),
  ClassificaEntry(pos: 4, nome: 'Trinacria 315pt', color: Color(0xFF4A90D9)),
  ClassificaEntry(
      pos: 5, nome: 'Vittorio Summano 310pt', color: Color(0xFF7B68EE)),
];

const List<ClassificaEntry> classificaMo2026 = [
  ClassificaEntry(pos: 1, nome: '???', color: Color(0xFFFFD700)),
  ClassificaEntry(pos: 2, nome: '???', color: Color(0xFFC0C0C0)),
  ClassificaEntry(pos: 3, nome: '???', color: Color(0xFFCD7F32)),
];

class _CreditiPageState extends State<CreditiPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final SetupCallback setupCallback = SetupCallback();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Crediti",
          backgroundColor: canvasColor,
          leading: IconButton(
            onPressed: () => setupCallback.onMenuPressed(context, _key),
            icon: const Icon(Icons.menu),
          ),
        ),
        body: const PalladioBody(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: CreditiTimeline(),
            ),
          ),
        ),
        drawer: PalladioDrawer(drawerKey: _key),
      ),
    );
  }
}

class ClassificaEntry {
  final int pos;
  final String nome;
  final Color color;
  final IconData? icon;

  const ClassificaEntry(
      {required this.pos, required this.nome, required this.color, this.icon});
}

class IconIndicator extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconIndicator({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedDotIndicator(
      color: color,
      size: 40,
      child: Center(
        child: Icon(icon),
      ),
    );
  }
}

class TrophyIndicator extends StatelessWidget {
  const TrophyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const DotIndicator(
      color: Color(0xFFFFD700),
      size: 40,
      child: Center(
        child: Icon(Icons.emoji_events, color: Colors.white, size: 22),
      ),
    );
  }
}

class DescriptiveCard extends StatelessWidget {
  final String title;
  final String description;

  const DescriptiveCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              description,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassificaCard extends StatelessWidget {
  final List<ClassificaEntry> entries;
  final String title;

  const ClassificaCard({super.key, required this.entries, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...entries.map((entry) => _ClassificaRow(entry: entry)),
          ],
        ),
      ),
    );
  }
}

class _ClassificaRow extends StatelessWidget {
  final ClassificaEntry entry;

  const _ClassificaRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.emoji_events, color: entry.color, size: 26),
          const SizedBox(width: 8),
          Text(
            '${entry.pos}°',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: entry.color,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          Text(entry.nome, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class _TimelineData {
  final Widget indicator;
  final Widget content;

  const _TimelineData({required this.indicator, required this.content});
}

class CreditiTimeline extends StatelessWidget {
  const CreditiTimeline({
    super.key,
  });

  List<_TimelineData> get _nodes => [
        const _TimelineData(
          indicator: IconIndicator(
              icon: Icons.military_tech, color: Colors.blueAccent),
          content: DescriptiveCard(
            title: '1996',
            description:
                'Creazione by Riky Frigo© del gioco di previsione risultati più richiesto ad oggi',
          ),
        ),
        const _TimelineData(
          indicator: IconIndicator(icon: Icons.terminal, color: Colors.green),
          content: DescriptiveCard(
            title: '2024',
            description: 'Creazione della versione digitale by Matteoberla',
          ),
        ),
        const _TimelineData(
          indicator: CharityIndicator(),
          content: CharityCard(),
        ),
        const _TimelineData(
          indicator: TrophyIndicator(),
          content: ClassificaCard(
            entries: classificaEu2024,
            title: 'Classifica Europei 2024',
          ),
        ),
        const _TimelineData(
          indicator: LoadingIndicator(),
          content: ClassificaCard(
            entries: classificaMo2026,
            title: 'Classifica Mondiali 2026',
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final nodes = _nodes;

    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: canvasColor,
        indicatorTheme: const IndicatorThemeData(position: 0, size: 40.0),
        connectorTheme: const ConnectorThemeData(thickness: 2.5),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: nodes.length,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 32),
          child: nodes[index].content,
        ),
        indicatorBuilder: (context, index) => nodes[index].indicator,
        connectorBuilder: (context, index, type) =>
            const SolidLineConnector(color: Colors.grey),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({
    super.key,
    this.color = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 37,
            height: 37,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: color,
            ),
          ),
          Icon(
            Icons.emoji_events,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class CharityCard extends StatelessWidget {
  const CharityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PalladioAssetImage(
              directory: "general",
              fileName: "cds_logo.jpg",
              width: width * 0.30,
            ),
            const Divider(),
            const Text(
              'Ci teniamo a ricordare che parte delle quote di partecipazione di ogni edizione vengono devolute in beneficenza alla Città della Speranza, fondazione impegnata nella ricerca oncologica pediatrica.',
              style: TextStyle(fontSize: 14, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CharityIndicator extends StatelessWidget {
  const CharityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const DotIndicator(
      color: Colors.redAccent,
      size: 40,
      child: Center(
        child: Icon(Icons.favorite, color: Colors.white, size: 20),
      ),
    );
  }
}
