import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/routes/onboarding.dart';
import 'package:okoul_quizu/routes/login/token_check.dart';
import 'package:okoul_quizu/routes/quiz/providers/questions_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (context) => QuestionsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var showHome = preferences.getBool(Constants.prefsShowHomeKey) ?? false;
    return MaterialApp(
      title: 'QuizU',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      debugShowCheckedModeBanner: false,
      home: showHome ? const TokenValidatePage() : const OnBoardingPage(),
    );
  }
}
