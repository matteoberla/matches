import 'package:flutter/material.dart';

class PalladioAssetImage extends StatelessWidget {
  const PalladioAssetImage(
      {super.key,
      required this.directory,
      required this.fileName,
      this.width,
      this.infinityWidth = false});

  final String directory;
  final String fileName;
  final bool infinityWidth;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$directory/$fileName',
      fit: BoxFit.fitHeight,
      width: infinityWidth ? double.infinity : width,
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
