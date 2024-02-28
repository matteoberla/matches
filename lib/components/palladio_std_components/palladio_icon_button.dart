import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

enum Size { small, medium, big }

class PalladioIconButton extends StatelessWidget {
  PalladioIconButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.backgroundColor,
      this.size = Size.small});

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Size size;

  final Map<Size, double> sizes = {
    Size.small: 0,
    Size.medium: 5,
    Size.big: 8,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const StadiumBorder(),
          ),
          onPressed: onPressed,
          icon: Icon(icon),
          label: Padding(
            padding: EdgeInsets.all(sizes[size]!),
            child: PalladioText(
              title,
              type: PTextType.h3,
            ),
          ),
        ),
      ],
    );
  }
}
