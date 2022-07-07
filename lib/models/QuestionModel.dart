class QuestionModel {

   late final String _question;

   late final Map<String, bool> _options;

   String get question => _question;
   Map<String, bool> get options => _options;


  set question(String value) {
    _question = value;
  }
  
  set options(Map<String, bool> value) {
    _options = value;
  }
}