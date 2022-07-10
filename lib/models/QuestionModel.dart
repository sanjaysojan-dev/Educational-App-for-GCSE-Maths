class QuestionModel {
  late final String _question;
  late final String _hint;
  late final Map<String, dynamic> _options;

  set setQuestionTitle(String value) {
    _question = value;
  }

  set setQuestionHint(String value) {
    _hint = value;
  }

  set setQuestionOptions(Map<String, dynamic> value) {
    _options = value;
  }

  String get hint => _hint;

  String get question => _question;

  Map<String, dynamic> get options => _options;
}
