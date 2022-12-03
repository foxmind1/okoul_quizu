import 'package:flutter/material.dart';
import 'package:okoul_quizu/features/quiz/providers/questions_provider.dart';
import 'package:okoul_quizu/features/quiz/score.dart';
import 'package:okoul_quizu/services/api_services.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';
import 'package:provider/provider.dart';

class QuizUtils {
  static void saveUserScoreAndNavigateToScorePage(BuildContext context) {
    int index = context.read<QuestionsProvider>().index;
    bool isClicked = context.read<QuestionsProvider>().hasSkipped;
    int score = isClicked ? index - 1 : index;

    SharedPrefsServices().saveLocalUserScore(score);
    ApiServices().insertScore(score);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => ScorePage(numOfCorrect: '$score')),
        (Route<dynamic> route) => false);

    context.read<QuestionsProvider>().resetQuiz();
  }
}
