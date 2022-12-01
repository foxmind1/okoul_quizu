import 'dart:convert';

import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/constants.dart';

class SharedPrefsServices {
  bool get getShowHome =>
      preferences.getBool(Constants.prefsShowHomeKey) ?? false;
  set setShowHome(bool value) =>
      preferences.setBool(Constants.prefsShowHomeKey, value);

  String get getToken => preferences.getString(Constants.prefsTokenKey) ?? "";
  set setToken(String value) =>
      preferences.setString(Constants.prefsTokenKey, value);

  List<String> get getUserScore =>
      preferences.getStringList(Constants.prefsUserScoreKey) ?? [];
  set setUserScore(List<String> value) =>
      preferences.setStringList(Constants.prefsUserScoreKey, value);

  void saveLocalUserScore(int currentQuizScore) {
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

  void resetPrefs() {
    preferences.remove(Constants.prefsTokenKey);
    preferences.remove(Constants.prefsUserScoreKey);
    preferences.remove(Constants.prefsShowHomeKey);
  }
}
