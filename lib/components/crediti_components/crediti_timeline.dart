import 'package:flutter/material.dart';
import 'package:matches/models/timeline_models/timeline_data.dart';
import 'package:matches/styles.dart';
import 'package:timelines_plus/timelines_plus.dart';

class CustomTimeline extends StatelessWidget {
  const CustomTimeline({super.key, required this.nodes});

  final List<TimelineData> nodes;

  @override
  Widget build(BuildContext context) {
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
