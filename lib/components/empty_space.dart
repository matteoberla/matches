import 'package:flutter/material.dart';

class EmptySpace extends StatelessWidget {
  const EmptySpace({this.height, this.width, super.key});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
