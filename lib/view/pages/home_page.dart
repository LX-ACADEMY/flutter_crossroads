import 'package:cross_roads/view/widgets/bottm_section_widget.dart';
import 'package:cross_roads/view/widgets/game_over_alert_widget.dart';
import 'package:cross_roads/view/widgets/list_view_widget.dart';
import 'package:cross_roads/view/widgets/top_section_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int score;
  late int highScore;
  late int subjectPosition;
  late int subjectHorizontalPos;
  late final ScrollController scrollController;
  late final GlobalKey subjectKey;
  late final GlobalKey listViewKey;
  late bool isGamePaused;

  @override
  void initState() {
    scrollController = ScrollController();
    subjectKey = GlobalKey();
    listViewKey = GlobalKey();
    subjectPosition = 0;
    score = 0;
    highScore = 0;
    subjectHorizontalPos = 0;
    isGamePaused = true;

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void resumeGame() {
    if (isGamePaused) {
      setState(() {
        isGamePaused = false;
      });
    }
  }

  void pauseGame() {
    if (!isGamePaused) {
      setState(() {
        isGamePaused = true;
      });
    }
  }

  void updateScore() {
    final newScore = subjectPosition * 10;

    if (score < newScore) {
      setState(() {
        score = newScore;

        if (newScore > highScore) {
          highScore = newScore;
        }
      });
    }
  }

  void moveLeft() {
    resumeGame();

    final subjectPosition =
        (subjectKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);

    if (subjectPosition.dx - 30 > 0) {
      setState(() {
        subjectHorizontalPos -= 30;
      });
    }
  }

  void moveRight() {
    resumeGame();

    final subjectPosition =
        (subjectKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
    final screenSize = MediaQuery.sizeOf(context).width;

    if (subjectPosition.dx + 30 < (screenSize - 30)) {
      setState(() {
        subjectHorizontalPos += 30;
      });
    }
  }

  void moveUp() {
    resumeGame();

    final subjectRenderBox =
        subjectKey.currentContext!.findRenderObject() as RenderBox;
    final listViewRenderBox =
        listViewKey.currentContext!.findRenderObject() as RenderBox;

    if (subjectRenderBox.localToGlobal(Offset.zero).dy - 130 >
        listViewRenderBox.localToGlobal(Offset.zero).dy) {
      setState(() {
        if (subjectPosition > 0) {
          subjectPosition--;
        }
      });
    }
  }

  void moveDown() {
    resumeGame();
    updateScore();

    final listViewStartOffset =
        (listViewKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
    final scrollEndPoint = scrollController.position.extentInside +
        scrollController.position.extentBefore;
    final listViewHeight = scrollController.position.extentInside;
    final subjectRenderBox =
        subjectKey.currentContext!.findRenderObject() as RenderBox;

    if (scrollEndPoint -
            (scrollEndPoint -
                listViewHeight +
                (subjectRenderBox.localToGlobal(Offset.zero).dy -
                    listViewStartOffset.dy)) >
        130) {
      setState(() {
        subjectPosition++;
      });
    }
  }

  void restartGame() {
    if (!isGamePaused) {
      pauseGame();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => GameOverAlertWidget(
            onReset: () {
              setState(() {
                subjectPosition = 0;
                score = 0;
                subjectHorizontalPos = 0;

                scrollController.jumpTo(0);
              });

              Navigator.pop(context);
            },
            currentScore: score,
            highScore: highScore),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TopSectionWidget(
            score: score,
            highScore: highScore,
            isGamePaused: isGamePaused,
            pauseCallback: pauseGame,
            resumeCallback: resumeGame,
          ),
          Expanded(
              child: ListViewWidget(
            isGamePaused: isGamePaused,
            score: score,
            resetGame: restartGame,
            highScore: highScore,
            subjectHorizontalPos: subjectHorizontalPos,
            listViewKey: listViewKey,
            scrollController: scrollController,
            subjectKey: subjectKey,
            subjectPositon: subjectPosition,
          )),
          BottmSectionWidget(
            moveLeftCallback: moveLeft,
            moveRightCallback: moveRight,
            moveDownCallback: moveDown,
            moveUpCallback: moveUp,
          ),
        ],
      ),
    ));
  }
}
