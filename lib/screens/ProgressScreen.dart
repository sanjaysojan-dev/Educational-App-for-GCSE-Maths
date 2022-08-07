import 'package:educational_app_for_maths/models/ChartModel.dart';
import 'package:flutter/material.dart';
import '../utils/FirestoreUtil.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'HomeScreen.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  FirestoreUtil firestoreUtil = new FirestoreUtil();

  //List to store data for chart model
  List<ChartModel> data = <ChartModel>[];

  //List to store series data for chart model
  List<charts.Series<ChartModel, String>> series =
  <charts.Series<ChartModel, String>>[];

  Stream? scores;

  ///Obtains the score of the users.
  @override
  void initState() {
    firestoreUtil.getScores().then((value) {
      setState(() {
        scores = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: firestoreUtil.getScores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            firestoreUtil.userScores.getScores.forEach((key, value) {
              ChartModel dataValue = ChartModel(
                  quiz: key.substring(0, 10),
                  score: value,
                  barColor: value >= 2
                      ? charts.ColorUtil.fromDartColor(Colors.green.shade400)
                      : charts.ColorUtil.fromDartColor(
                          Colors.deepOrangeAccent));
              data.add(dataValue);
            });

            series = [
              charts.Series(
                id: "Quiz Progress",
                data: data,
                domainFn: (ChartModel series, _) => series.quiz,
                // value of that will be on the horizontal side of the bar
                measureFn: (ChartModel series, _) => series.score,
                // points to the quantity on the vertical side
                colorFn: (ChartModel series, _) =>
                    series.barColor, // color of the bars
              ),
            ];

            //print (firestoreUtil.userScores.getScores.length);
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.yellow.shade700,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
                      onPressed: () {
                        // passing this to our root
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      }),
                  actions: [],
                  title: Text("Progress",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20)),
                  centerTitle: true,
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Column(children: <Widget>[
                      Text(
                        "Quiz Progress Results",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w700),
                      ),
                      Expanded(
                          child: charts.BarChart(
                        series,
                        animate: true,
                        behaviors: [
                          new charts.ChartTitle('Quizzes',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                          new charts.ChartTitle('Score',
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                        ],
                      )),
                    ])));
          } else {
            return Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              height: 200,
              width: 200,
            ));
          }
        },
      );
}
