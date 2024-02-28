import 'package:flutter/material.dart';

class PalladioAssetImage extends StatelessWidget {
  const PalladioAssetImage(
      {super.key,
      required this.directory,
      required this.fileName,
      this.infinityWidth = false});

  final String directory;
  final String fileName;
  final bool infinityWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$directory/$fileName',
      fit: BoxFit.fitHeight,
      width: infinityWidth ? double.infinity : null,
      errorBuilder:
          (BuildContext? context, Object? exception, StackTrace? stackTrace) {
        return Image.asset(
          'assets/general/file_not_found.png',
          fit: BoxFit.fitHeight,
          width: infinityWidth ? double.infinity : null,
        );
      },
    );
  }
}
