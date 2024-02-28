import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class PalladioAppBarIconButton extends StatelessWidget {
  const PalladioAppBarIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: PalladioText(
            title,
            type: PTextType.h3,
          ),
        ),
        const EmptySpace(
          width: 5,
        ),
      ],
    );
  }
}
