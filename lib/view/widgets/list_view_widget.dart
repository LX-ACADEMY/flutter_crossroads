import 'dart:async';
import 'package:cross_roads/view/widgets/road_widget.dart';
import 'package:cross_roads/view/widgets/safezone_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListViewWidget extends StatefulWidget {
  final int subjectPositon;
  final int subjectHorizontalPos;
  final ScrollController scrollController;
  final GlobalKey subjectKey;
  final GlobalKey listViewKey;
  final int score;
  final int highScore;
  final VoidCallback resetGame;
  final bool isGamePaused;

  const ListViewWidget(
      {super.key,
      required this.isGamePaused,
      required this.resetGame,
      required this.highScore,
      required this.score,
      required this.subjectHorizontalPos,
      required this.listViewKey,
      required this.subjectPositon,
      required this.scrollController,
      required this.subjectKey});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Timer? timer;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      final subjectPos =
          (widget.subjectKey.currentContext!.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
      final listViewPos =
          (widget.listViewKey.currentContext!.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);

      if (subjectPos.dy <= listViewPos.dy) {
        widget.resetGame();
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ListViewWidget oldWidget) {
    timer?.cancel();
    timer = null;

    if (!widget.isGamePaused) {
      timer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
        widget.scrollController.jumpTo(widget.scrollController.offset + 1);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      key: widget.listViewKey,
      // physics: const NeverScrollableScrollPhysics(),
      controller: widget.scrollController,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SafezoneWidget(
            key: ValueKey(index),
            subjectKey: widget.subjectKey,
            height: 200,
            subjectHorizontalPos: widget.subjectHorizontalPos,
            isSubjectPresent: index == widget.subjectPositon,
          );
        } else {
          if (index % 4 != 0) {
            return RoadWidget(
              key: ValueKey(index),
              reverse: index % 2 == 0,
              isGamePaused: widget.isGamePaused,
              score: widget.score,
              resetGame: widget.resetGame,
              highScore: widget.highScore,
              subjectKey: widget.subjectKey,
              subjectHorizontalPos: widget.subjectHorizontalPos,
              isSubjectPresent: index == widget.subjectPositon,
            );
          } else {
            return SafezoneWidget(
              key: ValueKey(index),
              subjectKey: widget.subjectKey,
              subjectHorizontalPos: widget.subjectHorizontalPos,
              height: 100,
              isSubjectPresent: index == widget.subjectPositon,
            );
          }
        }
      },
    );
  }
}
