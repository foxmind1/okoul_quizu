import 'dart:convert';

import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/constants/constants.dart';

class SharedPrefsServices {
  static bool get getShowHome =>
      preferences.getBool(Constants.prefsShowHomeKey) ?? false;
  static set setShowHome(bool value) =>
      preferences.setBool(Constants.prefsShowHomeKey, value);

  static String get getToken =>
      preferences.getString(Constants.prefsTokenKey) ?? "";
  static set setToken(String value) =>
      preferences.setString(Constants.prefsTokenKey, value);

  static List<String> get getUserScore =>
      preferences.getStringList(Constants.prefsUserScoreKey) ?? [];
  static set setUserScore(List<String> value) =>
      preferences.setStringList(Constants.prefsUserScoreKey, value);

  static void saveLocalUserScore(int currentQuizScore) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    var currentScores = getUserScore;

    Map<String, dynamic> newScore = {
      "date": date.toString().substring(0, 10),
      "score": "$currentQuizScore"
    };

    currentScores.add(jsonEncode(newScore));
    setUserScore = currentScores;
  }

  static void resetPrefs() {
    preferences.remove(Constants.prefsTokenKey);
    preferences.remove(Constants.prefsUserScoreKey);
    preferences.remove(Constants.prefsShowHomeKey);
  }
}
