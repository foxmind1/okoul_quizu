class Question {
  String? _question, _optionA, _optionB, _optionC, _optionD, _correctOption;

  Question(this._question, this._optionA, this._optionB, this._optionC,
      this._optionD, this._correctOption);

  String? get getQuestion => _question;
  String? get getOptionA => _optionA;
  String? get getOptionB => _optionB;
  String? get getOptionC => _optionC;
  String? get getOptionD => _optionD;
  String? get getCorrect => _correctOption;

  Question.fromJson(Map<String, dynamic> json) {
    _question = json['Question'];
    _optionA = json['a'];
    _optionB = json['b'];
    _optionC = json['c'];
    _optionD = json['d'];
    _correctOption = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Question'] = _question;
    data['a'] = _optionA;
    data['b'] = _optionB;
    data['c'] = _optionC;
    data['d'] = _optionD;
    data['correct'] = _correctOption;
    return data;
  }

  bool isCorrect(String selectedOption) => _correctOption == selectedOption;
}
