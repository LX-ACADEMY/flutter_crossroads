import 'package:cross_roads/view/widgets/subject_widget.dart';
import 'package:flutter/material.dart';

class SafezoneWidget extends StatelessWidget {
  final double height;
  final bool isSubjectPresent;
  final int subjectHorizontalPos;
  final Key subjectKey;

  const SafezoneWidget({
    super.key,
    required this.subjectHorizontalPos,
    required this.height,
    required this.subjectKey,
    required this.isSubjectPresent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Container(
            height: height,
            width: double.infinity,
            color: const Color.fromARGB(255, 107, 191, 177),
            child: Image.network(
              "https://cdn.creazilla.com/illustrations/7823178/green-grass-background-illustration-sm.png",
              fit: BoxFit.fill,
            ),
          ),
          if (isSubjectPresent)
            Positioned(
              bottom: 35,
              left: MediaQuery.sizeOf(context).width / 2 -
                  15 +
                  subjectHorizontalPos,
              child: SubjectWidget(key: subjectKey),
            ),
        ],
      ),
    );
  }
}
