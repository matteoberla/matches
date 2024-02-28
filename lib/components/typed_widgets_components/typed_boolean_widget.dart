import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class TypedBooleanWidget extends StatelessWidget {
  const TypedBooleanWidget(
      {super.key,
      required this.onPressed,
      required this.status,
      this.enabled = true});

  final VoidCallback onPressed;
  final bool status;
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
            status ? Icons.check_box_outlined : Icons.check_box_outline_blank),
      ),
    );
  }
}
