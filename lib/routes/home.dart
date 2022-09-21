import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/models/question.dart';
import 'package:okoul_quizu/routes/quiz.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        children: [
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/quiz.svg',
                    fit: BoxFit.contain, width: 180),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Welcome to QuizU',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26)),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      'Are you ready to test your knowledge and challenge others?',
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      startQuiz(context);

                      // var response = await http.get(
                      //     Uri.parse("https://quizu.okoul.com/Questions"),
                      //     headers: {
                      //       'Authorization':
                      //           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODUsImlhdCI6MTY2MzYyNTQ0Nn0.gMAHzu4YuoPjk2VASG5d-JlL6fIp6uhtXzyH4kx6gro'
                      //     });

                      // if (response.statusCode == 200) {
                      //   debugPrint("${jsonDecode(response.body)}");
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) =>
                      //           QuizPage(questions: [response.body])));
                      // } else {
                      //   debugPrint("${response.statusCode}");
                      // }

                      //TODO: What to do if user leaves in the middle of the quiz

                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const QuizPage()),
                      //     (Route<dynamic> route) => false);
                    },
                    child: const Text("Start Quiz!")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'Answer as much questions correctly within 2 minutes',
                      style: theme.textTheme.bodyText2,
                      textAlign: TextAlign.center,
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

void startQuiz(BuildContext context, [bool mounted = true]) async {
  var response =
      await http.get(Uri.parse("https://quizu.okoul.com/Questions"), headers: {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODUsImlhdCI6MTY2MzYyNTQ0Nn0.gMAHzu4YuoPjk2VASG5d-JlL6fIp6uhtXzyH4kx6gro'
  });

  if (!mounted) return;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body) as List;

    List<Question> questionList = [];
    for (var question in data) {
      questionList.add(Question(question['Question'], question['a'],
          question['b'], question['c'], question['d'], question['correct']));
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => QuizPage(questions: questionList)));
  } else {
    debugPrint("${response.statusCode}");
  }
}
