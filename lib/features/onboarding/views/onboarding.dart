import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:okoul_quizu/features/login/views/token_check.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'Welcome to QuizU',
            body: 'QuizU helps you test your knowledge across different topics',
            image: SvgPicture.asset("assets/intro/welcome.svg"),
            decoration: titleAndBodyDecoration(context)),
        PageViewModel(
            title: 'Challenge Everybody',
            body:
                'Challenge everyone to get into the top 10 of the leaderboard',
            image: SvgPicture.asset("assets/intro/everyone.svg"),
            decoration: titleAndBodyDecoration(context)),
        PageViewModel(
            title: '30 Questions in 2 minutes',
            body:
                'Answer as much as you can,\nYou can also skip one question per quiz',
            image: SvgPicture.asset("assets/intro/time.svg"),
            decoration: titleAndBodyDecoration(context))
      ],
      done: const Text('Done'),
      onDone: () {
        SharedPrefsServices.setShowHome = true;

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TokenValidatePage()),
            (Route<dynamic> route) => false);
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ));
  }
}

PageDecoration titleAndBodyDecoration(BuildContext context) {
  return PageDecoration(
    bodyPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    titlePadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    bodyAlignment: Alignment.center,
    imagePadding: const EdgeInsets.all(64),
  );
}
