import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class PalladioButton extends StatelessWidget {
  const PalladioButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PalladioText(
          title,
          type: PTextType.h3,
        ),
      ),
    );
  }
}
