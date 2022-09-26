import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:okoul_quizu/routes/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future isValidToken() async {
    var tokenIsAvailable =
        preferences.getString('token') != null ? true : false;

    if (tokenIsAvailable) {
      var response = await http.get(Uri.parse("https://quizu.okoul.com/Token"),
          headers: {
            'Authorization': 'Bearer ${preferences.getString('token')}'
          });

      return jsonDecode(response.body)['success'];
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: isValidToken(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text(snapshot.error.toString())),
                );
              } else if (snapshot.hasData) {
                return snapshot.data ? const Home() : const LoginPage();
              } else {
                return const Text('No data');
              }
          }
        },
      ),
    );
  }
}
