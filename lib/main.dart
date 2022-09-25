import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:okoul_quizu/routes/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var tokenIsValid = preferences.getString('token') != null ? true : false;

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      debugShowCheckedModeBanner: false,
      home: tokenIsValid ? const Home() : const LoginPage(),
    );
  }
}
