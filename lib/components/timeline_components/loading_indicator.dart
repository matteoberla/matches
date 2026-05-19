import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({
    super.key,
    this.color = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 37,
            height: 37,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: color,
            ),
          ),
          Icon(
            Icons.emoji_events,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }
}
