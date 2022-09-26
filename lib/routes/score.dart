import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:share_plus/share_plus.dart';

class ScorePage extends StatelessWidget {
  final String numOfCorrect;
  const ScorePage({Key? key, required this.numOfCorrect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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
                          MaterialPageRoute(builder: (context) => const Home()),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.close, color: theme.colorScheme.primary))
              ],
            ),
            Text(
              "Congratulations",
              style: theme.textTheme.headline4,
            ),
            SvgPicture.asset(
              'assets/score.svg',
              fit: BoxFit.contain,
              width: 200,
            ),
            Text(
              'You have completed $numOfCorrect questions correctly!',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            IconButton(
                iconSize: 46,
                onPressed: () async {
                  await Share.share(
                      'I answered $numOfCorrect correct answers in QuizU!');
                },
                icon: const Icon(Icons.share))
          ],
        ),
      ),
    );
  }
}
