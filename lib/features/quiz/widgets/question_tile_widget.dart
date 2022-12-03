import 'package:flutter/material.dart';
import 'package:okoul_quizu/features/quiz/providers/questions_provider.dart';
import 'package:okoul_quizu/features/quiz/utils/quiz_utils.dart';
import 'package:okoul_quizu/features/quiz/wrong_answer.dart';
import 'package:provider/provider.dart';

import 'package:okoul_quizu/models/question.dart';

class QuestionTile extends StatelessWidget {
  final List<Question> questions;
  final int index;
  final String option;

  const QuestionTile(
      {Key? key,
      required this.questions,
      required this.index,
      required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          if (questions[index].isCorrect(option)) {
            context.read<QuestionsProvider>().nextQuestion();
            if (index == questions.length - 1) {
              QuizUtils.saveUserScoreAndNavigateToScorePage(context);
            }
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const WrongAnswerPage()),
                (Route<dynamic> route) => false);

            context.read<QuestionsProvider>().resetQuiz();
          }
        },
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
        ),
        child: Text(
          '${option.toUpperCase()}. ${questionText(option, questions[index])}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

String? questionText(String option, Question questions) {
  if (option == 'a') {
    return questions.getOptionA;
  } else if (option == 'b') {
    return questions.getOptionB;
  } else if (option == 'c') {
    return questions.getOptionC;
  } else if (option == 'd') {
    return questions.getOptionD;
  }
  return 'Error';
}
