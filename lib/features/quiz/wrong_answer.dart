import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/features/quiz/quiz.dart';

import '../../nav_bar.dart';

class WrongAnswerPage extends StatelessWidget {
  const WrongAnswerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 32, left: 32, bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.close, color: theme.colorScheme.primary))
              ],
            ),
            Text(
              "Wrong answer, Sorry :(",
              style: TextStyle(fontSize: 34, color: theme.colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(
              'assets/wrong.svg',
              fit: BoxFit.contain,
              width: 200,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const QuizPage()));
                },
                child: const Text('Try again'))
          ],
        ),
      ),
    );
  }
}
