import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/home_page.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.close, color: theme.colorScheme.primary))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
              'You have completed 10 questions correctly!',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.share, size: 46))
          ],
        ),
      ),
    );
  }
}
