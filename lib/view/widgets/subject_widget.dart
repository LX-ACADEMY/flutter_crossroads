import 'package:flutter/material.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
