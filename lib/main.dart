import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
