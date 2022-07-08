class QuestionModel {

   late final String _question;

   late final Map<String, dynamic> _options;

   String get question => _question;
   Map<String, dynamic> get options => _options;


  set setQuestionTitle(String value) {
    _question = value;
  }

  set setQuestionOptions(Map<String, dynamic> value) {
    _options = value;
  }
}