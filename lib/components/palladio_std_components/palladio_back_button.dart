import 'package:flutter/material.dart';

class PalladioBackButton extends StatelessWidget {
  const PalladioBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_back),
    );
  }
}
