import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class PalladioToggleButtons extends StatelessWidget {
  const PalladioToggleButtons({
    super.key,
    required this.statusesList,
    required this.toggleButtonOnPressed,
    required this.buttons,
  });

  final List<bool> statusesList;
  final Function(int index) toggleButtonOnPressed;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: statusesList,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedColor: backgroundColor,
      fillColor: selectedColor,
      color: backgroundColor,
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      onPressed: toggleButtonOnPressed,
      children: buttons,
    );
  }
}
