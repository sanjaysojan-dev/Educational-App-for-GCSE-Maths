class QuestionModel {
  late final String _question;
  late final String _hint;
  late final String _image;
  late final Map<String, dynamic> _options;
  late final Map<String, Map<String, dynamic>> _solutions;


  set setQuestionTitle(String value) {
    _question = value;
  }

  set setQuestionHint(String value) {
    _hint = value;
  }

  set setImage(String value) {
    _image = value;
  }

  set setQuestionOptions(Map<String, dynamic> value) {
    _options = value;
  }

  set setSolutions(Map<String, Map<String, dynamic>> value) {
    _solutions = value;
  }

  String get hint => _hint;

  String get question => _question;

  String get image => _image;

  Map<String, dynamic> get options => _options;

  Map<String, Map<String, dynamic>> get solutions => _solutions;
}
