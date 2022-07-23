class ScoreModel {

  late Map<String, dynamic> _scores = Map<String, dynamic>();

  Map<String, dynamic> get getScores => _scores;

  set setScores(Map<String, dynamic> value) {
    _scores = value;
  }

}