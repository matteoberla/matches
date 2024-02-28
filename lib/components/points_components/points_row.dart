import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class PointsRow extends StatelessWidget {
  const PointsRow({
    super.key,
    required this.description,
    required this.points,
    this.boldDescription = false,
  });

  final String description;
  final String? points;
  final bool boldDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: PalladioText(
            description,
            type: PTextType.h3,
            bold: boldDescription,
          ),
        ),
        PalladioText(
          " $points Punti",
          type: PTextType.h3,
        ),
      ],
    );
  }
}
