import 'package:flutter/material.dart';

class TopSectionWidget extends StatelessWidget {
  final int score;
  final int highScore;
  final VoidCallback resumeCallback;
  final VoidCallback pauseCallback;
  final bool isGamePaused;

  const TopSectionWidget({
    super.key,
    required this.score,
    required this.highScore,
    required this.isGamePaused,
    required this.pauseCallback,
    required this.resumeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Score : $score",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "HighScore : $highScore",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: isGamePaused ? resumeCallback : pauseCallback,
            icon: Icon(
              isGamePaused ? Icons.play_arrow : Icons.pause,
            ),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shadowColor: MaterialStatePropertyAll(Colors.black),
              elevation: MaterialStatePropertyAll(10),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
