import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/routes/score.dart';
import 'package:okoul_quizu/routes/wrong_answer_.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  const QuizPage({Key? key, required this.questions}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

int _index = 0;
bool _isClicked = false;

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var questions = widget.questions;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                      duration: 120,
                      initialDuration: 0,
                      controller: CountDownController(),
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.height / 5.5,
                      // ringColor: Colors.white,
                      ringColor: theme.colorScheme.background,
                      fillColor: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.primary,
                      strokeWidth: 8.0,
                      textStyle: TextStyle(
                          fontSize: 20.0,
                          // color: Colors.white,
                          color: theme.colorScheme.background,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: true,
                      autoStart: true,
                      onComplete: () {
                        saveUserScore(context);
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
                                        if (questions[_index].getCorrect ==
                                            'a') {
                                          if (_index != questions.length - 1) {
                                            setState(() {
                                              _index += 1;
                                            });
                                          } else {
                                            _index += 1;
                                            saveUserScore(context);
                                          }
                                        } else {
                                          goToWrongPage(context);
                                          reset();
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
                                        if (questions[_index].getCorrect ==
                                            'b') {
                                          if (_index != questions.length - 1) {
                                            setState(() {
                                              _index += 1;
                                            });
                                          } else {
                                            _index += 1;
                                            saveUserScore(context);
                                          }
                                        } else {
                                          goToWrongPage(context);
                                          reset();
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
                                        if (questions[_index].getCorrect ==
                                            'c') {
                                          if (_index != questions.length - 1) {
                                            setState(() {
                                              _index += 1;
                                            });
                                          } else {
                                            _index += 1;
                                            saveUserScore(context);
                                          }
                                        } else {
                                          goToWrongPage(context);
                                          reset();
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
                                        if (questions[_index].getCorrect ==
                                            'd') {
                                          if (_index != questions.length - 1) {
                                            setState(() {
                                              _index += 1;
                                            });
                                          } else {
                                            _index += 1;
                                            saveUserScore(context);
                                          }
                                        } else {
                                          goToWrongPage(context);
                                          reset();
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
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.skip_next),
                                          onPressed: _isClicked
                                              ? null
                                              : () {
                                                  if (_index !=
                                                      questions.length - 1) {
                                                    setState(() {
                                                      _index += 1;
                                                      _isClicked = true;
                                                    });
                                                  }
                                                },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      theme.colorScheme
                                                          .tertiary)),
                                          label: const Text("Skip"),
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
        ),
      ),
    );
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

void goToWrongPage(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WrongAnswerPage()),
      (Route<dynamic> route) => false);
}

void reset() {
  _index = 0;
  _isClicked = false;
}

void saveUserScore(BuildContext context) {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);

  var currentScores = preferences.getStringList('user_scores') ?? [];

  int current = _isClicked ? _index - 1 : _index;

  Map<String, dynamic> newScore = {
    "date": date.toString().substring(0, 10),
    "score": "$current"
  };

  currentScores.add(jsonEncode(newScore));
  preferences.setStringList('user_scores', currentScores);

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => ScorePage(numOfCorrect: '$current')),
      (Route<dynamic> route) => false);
  http.post(Uri.parse("https://quizu.okoul.com/Score"),
      body: {'score': "$current"},
      headers: {'Authorization': "Bearer ${preferences.getString('token')}"});

  reset();
}
