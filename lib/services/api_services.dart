import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:okoul_quizu/constants/constants.dart';
import 'package:okoul_quizu/models/question.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';

class ApiServices {
//TODO: Add error handling

  static void insertScore(int current) {
    http.post(
      Uri.parse(Constants.apiUserScore),
      body: {'score': "$current"},
      headers: {'Authorization': "Bearer ${SharedPrefsServices.getToken}"},
    );
  }

  static void insertName(String name) {
    http.post(
      Uri.parse(Constants.apiName),
      body: {"name": name},
      headers: {'Authorization': 'Bearer ${SharedPrefsServices.getToken}'},
    );
  }

  static Future<http.Response> login(String otp, String mobile) {
    return http.post(
      Uri.parse(Constants.apiLogin),
      body: {"OTP": otp, "mobile": mobile},
    );
  }

  static Future<http.Response> verfiyToken() {
    return http.get(
      Uri.parse(Constants.apiToken),
      headers: {'Authorization': 'Bearer ${SharedPrefsServices.getToken}'},
    );
  }

  static Future<List<Question>> getQuestions() async {
    final response = await http.get(
      Uri.parse(Constants.apiQuestions),
      headers: {'Authorization': 'Bearer ${SharedPrefsServices.getToken}'},
    );

    return (jsonDecode(response.body) as List)
        .map((question) => Question.fromJson(question))
        .toList();
  }

  static Future<http.Response> getLeaderboard() {
    return http.get(
      Uri.parse(Constants.apiTopScores),
      headers: {'Authorization': "Bearer ${SharedPrefsServices.getToken}"},
    );
  }

  static Future<http.Response> getUserInfo() {
    return http.get(
      Uri.parse(Constants.apiUserInfo),
      headers: {'Authorization': 'Bearer ${SharedPrefsServices.getToken}'},
    );
  }
}
