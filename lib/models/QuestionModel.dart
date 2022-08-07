class QuestionModel {
  late final String _question;
  late final String _hint;
  late final String _image;
  late final Map<String, dynamic> _options;
  late final Map<String, Map<String, dynamic>> _solutions;


  ///Sets question title
  set setQuestionTitle(String value) {
    _question = value;
  }

  ///Sets the question hint
  set setQuestionHint(String value) {
    _hint = value;
  }

  ///Sets the image location
  set setImage(String value) {
    _image = value;
  }

  ///Maps option stream and its value to map
  set setQuestionOptions(Map<String, dynamic> value) {
    _options = value;
  }

  ///Maps value of solutions
  set setSolutions(Map<String, Map<String, dynamic>> value) {
    _solutions = value;
  }

  String get hint => _hint;

  String get question => _question;

  String get image => _image;

  Map<String, dynamic> get options => _options;

  Map<String, Map<String, dynamic>> get solutions => _solutions;
}
