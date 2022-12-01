import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:okoul_quizu/constants.dart';
import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/models/question.dart';

class ApiServices {
//TODO: Add try/catch

  void insertScore(int current) {
    http.post(
      Uri.parse(Constants.apiUserScore),
      body: {'score': "$current"},
      headers: {
        'Authorization':
            "Bearer ${preferences.getString(Constants.prefsTokenKey)}"
      },
    );
  }

  void insertName(name) {
    http.post(
      Uri.parse(Constants.apiName),
      body: {"name": name},
      headers: {
        'Authorization':
            'Bearer ${preferences.getString(Constants.prefsTokenKey)}'
      },
    );
  }

  void login(otp, mobile) {
    http.post(
      Uri.parse(Constants.apiLogin),
      body: {"OTP": otp, "mobile": mobile},
    );
  }

  void verfiyToken() {
    http.get(
      Uri.parse(Constants.apiToken),
      headers: {
        'Authorization':
            'Bearer ${preferences.getString(Constants.prefsTokenKey)}'
      },
    );
  }

  Future<List<Question>> getQuestions() async {
    final response = await http.get(
      Uri.parse(Constants.apiQuestions),
      headers: {
        'Authorization':
            'Bearer ${preferences.getString(Constants.prefsTokenKey)}'
      },
    );

    return (jsonDecode(response.body) as List)
        .map((question) => Question.fromJson(question))
        .toList();
  }

  void getLeaderboard() {
    http.get(
      Uri.parse(Constants.apiTopScores),
      headers: {
        'Authorization':
            "Bearer ${preferences.getString(Constants.prefsTokenKey)}"
      },
    );
  }

  void getUserInfo() {
    http.get(
      Uri.parse(Constants.apiUserInfo),
      headers: {
        'Authorization':
            'Bearer ${preferences.getString(Constants.prefsTokenKey)}'
      },
    );
  }
}
