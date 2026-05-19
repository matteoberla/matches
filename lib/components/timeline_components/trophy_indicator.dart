import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

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
