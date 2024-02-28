import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class PalladioDrawerMenuTile extends StatelessWidget {
  const PalladioDrawerMenuTile(
      {super.key, required this.selected, required this.child});

  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 5.0, bottom: 5.0, right: selected ? 8.0 : 15.0),
      child: Container(
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: selected ? 4.0 : 0.0,
            left: selected ? 3.0 : 0.0,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: child),
          ),
        ),
      ),
    );
  }
}
