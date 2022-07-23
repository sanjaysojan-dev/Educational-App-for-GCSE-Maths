import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/ChartModel.dart';

import 'package:flutter/material.dart';

import '../models/ScoreModel.dart';
import '../utils/FirestoreUtil.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'HomeScreen.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  FirestoreUtil firestoreUtil = new FirestoreUtil();

  var testWidgets = <Widget>[];

  List<ChartModel> data = <ChartModel>[];
  List<charts.Series<ChartModel, String>> series =
      <charts.Series<ChartModel, String>>[];

  Stream? scores;

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
            //firestoreUtil.getScores();

            print(firestoreUtil.userScores.getScores.length);
            firestoreUtil.userScores.getScores.forEach((key, value) {
              ChartModel dataValue = ChartModel(
                  quiz: key,
                  score: value,
                  barColor: value > 2
                      ? charts.ColorUtil.fromDartColor(Colors.green)
                      : charts.ColorUtil.fromDartColor(
                          Colors.deepOrangeAccent));
              data.add(dataValue);
              print(key);
            });

            series = [
              charts.Series(
                id: "Testing",
                data: data,
                domainFn: (ChartModel series, _) => series.quiz,
                measureFn: (ChartModel series, _) => series.score,
                colorFn: (ChartModel series, _) => series.barColor,

              ),
            ];

            //print (firestoreUtil.userScores.getScores.length);
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.yellow.shade700,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
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
                      Text("Quiz Progress Results"),
                      Expanded(
                          child:
                          charts.BarChart(series, animate: true, behaviors: [
                            new charts.ChartTitle('Quizzes',
                                behaviorPosition: charts.BehaviorPosition.bottom,
                                titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                            new charts.ChartTitle('Score',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                          ],)),
                    ])));
            return Center(
                child: Container(child: Text('hasData: ${snapshot.data}')));
          } else {
            // We can show the loading view until the data comes back.
            debugPrint('Step 1, build loading widget');
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
