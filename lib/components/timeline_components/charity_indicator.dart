import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

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
