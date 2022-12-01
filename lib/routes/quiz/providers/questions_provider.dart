import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:okoul_quizu/models/question.dart';
import 'package:okoul_quizu/services/api_services.dart';

class QuestionsProvider extends ChangeNotifier {
  List<Question> _questionsList = [];
  int _index = 0;
  bool _hasSkipped = false;

  UnmodifiableListView<Question> get questionList =>
      UnmodifiableListView(_questionsList);
  int get index => _index;
  bool get hasSkipped => _hasSkipped;

  void fetchQuestions() async {
    _questionsList = await ApiServices().getQuestions();
    notifyListeners();
  }

  void nextQuestion() {
    _index++;
    notifyListeners();
  }

  void skipQuestion() {
    _hasSkipped = true;
    notifyListeners();
  }

  void resetQuiz() {
    _index = 0;
    _hasSkipped = false;
    // notifyListeners();
  }
}
