import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/styles.dart';

class TypedActionButtonWidget extends StatelessWidget {
  const TypedActionButtonWidget(
      {super.key,
      required this.onPressed,
      this.displayedValue,
      this.enabled = true});

  final VoidCallback onPressed;
  final String? displayedValue;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: mainColor),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor),
      onPressed: enabled
          ? onPressed
          : () {
              print("campo disabilitato");
            },
      child: PalladioText(
        "\n$displayedValue\n",
        type: PTextType.h4,
        textAlign: TextAlign.center,
      ),
    );
  }
}
