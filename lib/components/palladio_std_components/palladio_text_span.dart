import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class PalladioTextSpan {
  const PalladioTextSpan(
    this.text, {
    required this.type,
    this.bold = false,
    this.textColor,
  });

  final String text;
  final PTextType type;
  final bool bold;
  final Color? textColor;

  TextSpan getTextSpan() {
    return TextSpan(
      text: text,
      style: TextStyle(
          fontSize: palladioTextSizes[type],
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: textColor),
    );
  }
}
