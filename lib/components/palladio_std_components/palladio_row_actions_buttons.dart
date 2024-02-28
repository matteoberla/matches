import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_action_button.dart';
import 'package:matches/styles.dart';

class PalladioRowActionButtons extends StatelessWidget {
  const PalladioRowActionButtons(
      {super.key, required this.onSave, required this.onExit});

  final VoidCallback onSave;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EmptySpace(
          width: 10,
        ),
        PalladioActionButton(
          title: "Esci",
          onTap: onExit,
          backgroundColor: dangerColor,
        ),
        PalladioActionButton(
          title: "Salva",
          onTap: onSave,
          backgroundColor: interactiveColor,
        ),
        const EmptySpace(
          width: 10,
        ),
      ],
    );
  }
}
