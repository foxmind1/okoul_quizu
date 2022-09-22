import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home_page.dart';

class WrongAnswerPage extends StatelessWidget {
  const WrongAnswerPage({Key? key}) : super(key: key);

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
            icon: Icon(Icons.close, color: theme.colorScheme.primary),
          )
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
              "Wrong answer, Sorry :(",
              style: theme.textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(
              'assets/wrong.svg',
              fit: BoxFit.contain,
              width: 200,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Try again'))
          ],
        ),
      ),
    );
  }
}
