class Question {
  final String _question,
      _optionA,
      _optionB,
      _optionC,
      _optionD,
      _correctOption;

  Question(this._question, this._optionA, this._optionB, this._optionC,
      this._optionD, this._correctOption);

  String get getQuestion {
    return _question;
  }

  String get getOptionA {
    return _optionA;
  }

  String get getOptionB {
    return _optionB;
  }

  String get getOptionC {
    return _optionC;
  }

  String get getOptionD {
    return _optionD;
  }

  String get getCorrect {
    return _correctOption;
  }
}
