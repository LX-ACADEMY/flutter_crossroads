import 'package:flutter/material.dart';

class BottmSectionWidget extends StatelessWidget {
  final void Function() moveUpCallback;
  final void Function() moveDownCallback;
  final void Function() moveLeftCallback;
  final void Function() moveRightCallback;

  const BottmSectionWidget({
    super.key,
    required this.moveDownCallback,
    required this.moveUpCallback,
    required this.moveLeftCallback,
    required this.moveRightCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: moveLeftCallback,
              child: const Icon(Icons.arrow_circle_left_outlined)),
          ElevatedButton(
              onPressed: moveRightCallback,
              child: const Icon(Icons.arrow_circle_right_outlined)),
          ElevatedButton(
              onPressed: moveUpCallback,
              child: const Icon(Icons.arrow_circle_up)),
          ElevatedButton(
              onPressed: moveDownCallback,
              child: const Icon(Icons.arrow_circle_down)),
        ],
      ),
    );
  }
}
