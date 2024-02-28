import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class PalladioTabItem extends StatelessWidget {
  const PalladioTabItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: PalladioText(
        text,
        type: PTextType.h3,
        bold: true,
      ),
    );
  }
}
