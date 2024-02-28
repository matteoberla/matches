import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class PalladioGridTile extends StatelessWidget {
  const PalladioGridTile({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 1, // changes position of shadow
                  ),
                ]),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: child),
          ),
        ),
      ),
    );
  }
}
