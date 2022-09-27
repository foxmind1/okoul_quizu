import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../home_page.dart';
import '../main.dart';
import 'login.dart';

class TokenValidatePage extends StatelessWidget {
  const TokenValidatePage({Key? key}) : super(key: key);

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
    return Scaffold(
        body: FutureBuilder(
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
              return const Scaffold(
                body: Center(
                  child: Text("Problem has occurred please try again later"),
                ),
              );
            } else if (snapshot.hasData) {
              return snapshot.data ? const Home() : const LoginPage();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Problem has occurred please try again later'),
                ),
              );
            }
        }
      },
    ));
  }
}