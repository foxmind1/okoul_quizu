import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okoul_quizu/features/home/views/home_page_nav_bar.dart';
import 'package:okoul_quizu/services/api_services.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';
import 'login.dart';

class TokenValidatePage extends StatelessWidget {
  const TokenValidatePage({Key? key}) : super(key: key);

  Future isValidToken() async {
    var tokenIsAvailable = SharedPrefsServices.getToken != "" ? true : false;

    if (tokenIsAvailable) {
      var response = await ApiServices.verfiyToken();

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
                return snapshot.data
                    ? const HomePageNavBar()
                    : const LoginPage();
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Problem has occurred please try again later'),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
