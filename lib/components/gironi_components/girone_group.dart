import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/styles.dart';

class GironeGroup extends StatelessWidget {
  const GironeGroup({super.key, required this.girone});

  final Gironi girone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: interactiveColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
              child: PalladioText(
                girone.girone ?? "Nessuno",
                type: PTextType.h2,
                bold: true,
                textColor: lightTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
