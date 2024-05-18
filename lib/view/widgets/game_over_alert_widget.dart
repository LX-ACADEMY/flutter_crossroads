import 'dart:io';

import 'package:flutter/material.dart';

class GameOverAlertWidget extends StatelessWidget {
  final int currentScore;
  final int highScore;
  final VoidCallback onReset;

  const GameOverAlertWidget({
    required this.currentScore,
    required this.highScore,
    required this.onReset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Game Over!'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current score: $currentScore'),
          Text('High score: $highScore'),
        ],
      ),
      actions: [
        IconButton(
            onPressed: onReset, icon: const Icon(Icons.restart_alt_rounded)),
        IconButton(
            onPressed: () {
              exit(0);
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }
}
