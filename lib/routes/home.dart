import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/quiz.svg', fit: BoxFit.contain, width: 150),
          const Divider(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Welcome to QuizU',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            ],
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: const Text("Start Quiz")),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                'Answer as much question correctly within 2 minutes',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ],
      ),
    ));
  }
}
