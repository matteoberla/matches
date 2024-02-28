import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_loading.dart';
import 'package:matches/styles.dart';

class PalladioLoadingIcon extends StatelessWidget {
  const PalladioLoadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: PalladioLoading(
        absorbing: false,
        backgroundColor: transparent,
      ),
    );
  }
}
