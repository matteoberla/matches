import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/styles.dart';

class PalladioActionButton extends StatelessWidget {
  const PalladioActionButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.backgroundColor,
      this.textColor = lightTextColor});

  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PalladioText(
                title,
                type: PTextType.h1,
                bold: true,
                textColor: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
