import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/features/quiz/utils/quiz_utils.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 120,
      initialDuration: 0,
      controller: CountDownController(),
      width: MediaQuery.of(context).size.width / 5.5,
      height: MediaQuery.of(context).size.height / 5.5,
      ringColor: theme.colorScheme.background,
      fillColor: theme.colorScheme.secondary,
      backgroundColor: theme.colorScheme.primary,
      strokeWidth: 8.0,
      textStyle: TextStyle(
          fontSize: 20.0,
          color: theme.colorScheme.background,
          fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      autoStart: true,
      onComplete: () {
        QuizUtils.saveUserScoreAndNavigateToScorePage(context);
      },
    );
  }
}
