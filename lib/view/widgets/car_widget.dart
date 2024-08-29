import 'package:flutter/material.dart';

class CarWidget extends StatefulWidget {
  final GlobalKey subjectKey;
  final bool isSubjectPresent;
  final ScrollController roadScrollController;
  final int score;
  final int highScore;
  final VoidCallback resetGame;
  final bool isReverse;

  const CarWidget({
    required this.resetGame,
    required this.score,
    required this.highScore,
    required this.subjectKey,
    required this.isSubjectPresent,
    required this.roadScrollController,
    required this.isReverse,
    super.key,
  });

  @override
  State<CarWidget> createState() => _CarWidgetState();
}

class _CarWidgetState extends State<CarWidget> {
  @override
  void initState() {
    widget.roadScrollController.addListener(checkCarCollision);

    super.initState();
  }

  @override
  void dispose() {
    widget.roadScrollController.removeListener(checkCarCollision);

    super.dispose();
  }

  void checkCarCollision() {
    final carRenderBox = context.findRenderObject() as RenderBox;
    final subjectRenderBox =
        widget.subjectKey.currentContext!.findRenderObject() as RenderBox;

    final carTopLeft = carRenderBox.localToGlobal(Offset.zero);
    final carTopRight =
        carRenderBox.localToGlobal(Offset(carRenderBox.size.width, 0));
    final subjectTopLeft = subjectRenderBox.localToGlobal(Offset.zero);
    final subjectTopRight =
        subjectRenderBox.localToGlobal(Offset(subjectRenderBox.size.width, 0));

    // print('Car position: ${carRenderBox.localToGlobal(Offset.zero)}');
    // print('Subject position: ${subjectRenderBox.localToGlobal(Offset.zero)}');

    if (widget.isSubjectPresent &&
        ((subjectTopLeft.dx >= carTopLeft.dx &&
                subjectTopLeft.dx <= carTopRight.dx) ||
            (subjectTopRight.dx >= carTopLeft.dx &&
                subjectTopRight.dx <= carTopRight.dx))) {
      widget.resetGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      height: 40,
      width: 100,
      child: Transform.flip(
        flipX: !widget.isReverse,
        child: Image.asset(
          "assets/images-removebg-preview.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
