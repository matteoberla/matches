import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class PalladioDropdown extends StatelessWidget {
  const PalladioDropdown(
      {super.key,
      this.value,
      required this.items,
      required this.onChanged,
      this.enabled = true});

  final String? value;
  final List<DropdownMenuItem> items;
  final Function(dynamic)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton(
          dropdownColor: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          value: value,
          items: items,
          onChanged: onChanged,
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
