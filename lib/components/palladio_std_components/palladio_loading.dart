import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:matches/styles.dart';

class PalladioLoading extends StatelessWidget {
  const PalladioLoading({
    required this.absorbing,
    this.backgroundColor = opaqueColor,
    super.key,
  });

  final bool absorbing;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: Container(
        color: backgroundColor,
        child: const Center(
          child: GFLoader(
            size: 70,
            loaderstrokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
