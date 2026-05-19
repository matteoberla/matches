import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

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
