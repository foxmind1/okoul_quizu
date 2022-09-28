import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/routes/onboarding.dart';
import 'package:okoul_quizu/routes/login/token_check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart' as constants;

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var showHome = preferences.getBool(constants.prefsShowHomeKey) ?? false;
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
