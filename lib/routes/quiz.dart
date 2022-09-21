import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:okoul_quizu/routes/score.dart';

import '../models/question.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  const QuizPage({Key? key, required this.questions}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

int _index = 0;

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var questions = widget.questions;

    return Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircularCountDownTimer(
                      duration: 5,
                      initialDuration: 0,
                      controller: CountDownController(),
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.height / 5.5,
                      // ringColor: Colors.grey[300]!,
                      ringColor: Colors.white,
                      fillColor: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.primary,
                      strokeWidth: 8.0,
                      textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: true,
                      autoStart: true,
                      onStart: () {
                        // debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        //TODO: Go to score page and check if still active after wrong answer
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const ScorePage()),
                            (Route<dynamic> route) => false);
                      },
                      onChange: (String timeStamp) {
                        // debugPrint('Countdown Changed $timeStamp');
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Question ${_index + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(questions[_index].getQuestion,
                                      style: theme.textTheme.headline6,
                                      textAlign: TextAlign.start),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        //TODO: Check if last answer go to score page
                                        if (isCorrect(
                                            questions[_index].getCorrect,
                                            'a')) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      style: questionOptionStyle(),
                                      child: Text(
                                          "A. ${questions[_index].getOptionA}"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (isCorrect(
                                            questions[_index].getCorrect,
                                            'b')) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      style: questionOptionStyle(),
                                      child: Text(
                                          "B. ${questions[_index].getOptionB}"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (isCorrect(
                                            questions[_index].getCorrect,
                                            'c')) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      style: questionOptionStyle(),
                                      child: Text(
                                          "C. ${questions[_index].getOptionC}"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (isCorrect(
                                            questions[_index].getCorrect,
                                            'd')) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      style: questionOptionStyle(),
                                      child: Text(
                                          "D. ${questions[_index].getOptionD}"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      theme.colorScheme
                                                          .tertiary)),
                                          child: const Text("Skip"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

ButtonStyle questionOptionStyle() {
  return ButtonStyle(
    alignment: Alignment.centerLeft,
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
  );
}

bool isCorrect(String correctAnswer, String userAnswer) {
  return userAnswer == correctAnswer;
}
