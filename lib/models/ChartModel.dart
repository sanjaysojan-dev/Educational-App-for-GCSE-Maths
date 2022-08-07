import 'package:charts_flutter/flutter.dart' as charts;
class ChartModel {

  // Model for chart
String quiz;
int score;
final charts.Color barColor;

ChartModel({required this.quiz, required this.score, required  this.barColor});

}