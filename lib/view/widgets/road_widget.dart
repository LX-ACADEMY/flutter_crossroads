import 'dart:async';
import 'dart:math';

import 'package:cross_roads/view/widgets/car_widget.dart';
import 'package:cross_roads/view/widgets/subject_widget.dart';
import 'package:flutter/material.dart';

class RoadWidget extends StatefulWidget {
  final bool isSubjectPresent;
  final int subjectHorizontalPos;
  final GlobalKey subjectKey;
  final int score;
  final VoidCallback resetGame;
  final int highScore;
  final bool isGamePaused;
  final bool reverse;

  const RoadWidget({
    super.key,
    this.reverse = false,
    required this.isGamePaused,
    required this.resetGame,
    required this.highScore,
    required this.score,
    required this.subjectHorizontalPos,
    required this.isSubjectPresent,
    required this.subjectKey,
  });

  @override
  State<RoadWidget> createState() => _RoadWidgetState();
}

class _RoadWidgetState extends State<RoadWidget> {
  late final ScrollController roadScrollController;
  late final List<bool?> _carPosiotions;
  Timer? timer;

  @override
  void initState() {
    roadScrollController = ScrollController();
    _carPosiotions = List.generate(100, (index) => null);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RoadWidget oldWidget) {
    timer?.cancel();
    timer = null;

    if (!widget.isGamePaused) {
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        roadScrollController.jumpTo(roadScrollController.offset + 1);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 100,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                color: const Color.fromARGB(255, 50, 47, 47),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              height: 2,
                              width: 30,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                            ),
                          );
                        }),
                    ListView.builder(
                        reverse: widget.reverse,
                        controller: roadScrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (_carPosiotions[index % 100] == null) {
                            _carPosiotions[index % 100] =
                                (index + 1) % (Random().nextInt(10) + 1) == 0;
                          }

                          if (_carPosiotions[index % 100]!) {
                            return Center(
                              child: CarWidget(
                                score: widget.score,
                                resetGame: widget.resetGame,
                                highScore: widget.highScore,
                                isSubjectPresent: widget.isSubjectPresent,
                                subjectKey: widget.subjectKey,
                                roadScrollController: roadScrollController,
                              ),
                            );
                          }

                          return const SizedBox(
                            width: 80,
                          );
                        }),
                  ],
                ),
              ),
              Container(
                height: 8,
                width: double.infinity,
                color: const Color.fromARGB(255, 50, 47, 47),
              )
            ],
          ),
          if (widget.isSubjectPresent)
            Positioned(
              bottom: 35,
              left: MediaQuery.sizeOf(context).width / 2 -
                  15 +
                  widget.subjectHorizontalPos,
              child: SubjectWidget(key: widget.subjectKey),
            ),
        ],
      ),
    );
  }
}
