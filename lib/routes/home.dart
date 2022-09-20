import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/routes/quiz.dart';

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
                    onPressed: () {
                      //TODO: What to do if user leaves in the middle of the quiz

                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const QuizPage()),
                      //     (Route<dynamic> route) => false);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QuizPage()));
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
