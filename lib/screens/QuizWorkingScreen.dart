import 'package:educational_app_for_maths/screens/ProgressScreen.dart';
import 'package:flutter/material.dart';
import '../models/QuestionModel.dart';
import '../widgets/ExplanationCard.dart';
import '../widgets/NextQuestionButton.dart';
import '../widgets/StepTitleCard.dart';
import 'HomeScreen.dart';

class QuizWorkingScreen extends StatefulWidget {

  //A list to store the questions of the Topic
  List<QuestionModel> questions = <QuestionModel>[];

  QuizWorkingScreen(this.questions);

  @override
  _QuizWorkingScreenState createState() => _QuizWorkingScreenState(questions);
}

class _QuizWorkingScreenState extends State<QuizWorkingScreen> {
  List<QuestionModel> questions;

  int index = 0;

  bool onPressed = false;

  var stepWidgets = <Widget>[];

  _QuizWorkingScreenState(this.questions);

 ///Orders the order of solution values
  @override
  void initState() {
    setState(() {
      keyValueSolutionSort();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade700,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
              onPressed: () {
                // passing this to our root
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              }),
          actions: [],
          title: Text("Workings",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
          centerTitle: true,
        ),
        body: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          SingleChildScrollView(
            child: Center(
                child: Container(
              //padding: const EdgeInsets.symmetric(vertical: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  for (int i = 0; i < stepWidgets.length; i++) stepWidgets[i],

                  NextQuestionButton(nextQuestion: nextIndex, buttonTitle: ""),

                  //questionExtraction()
                ],
              ),
            )),
          )
        ]));
  }

  ///A method to increment counter and update the solution
  void nextIndex() {
    if (index != questions.length - 1) {
      setState(() {
        index++;
        stepWidgets = <Widget>[];
        keyValueSolutionSort();
      });
    } else if (index == questions.length - 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProgressScreen()));
    }
  }

  /// A method that iterates through the solution of each
  /// questions to then create
  keyValueSolutionSort() {
    var sortedKeys = questions[index].solutions.keys.toList()..sort();

    sortedKeys.forEach((element) {
      questions[index].solutions.forEach((key, value) {
        if (key == element) {
          var sortedValues = value.keys.toList()..sort();

          sortedValues.forEach((sortedValue) {

            if (sortedValue == 'title') {
              var step = StepTitleCard(title: value[sortedValue]);
              stepWidgets.add(step);
            } else {
              if (sortedValue == 'value10') {
                var step = ExplanationCard(
                  step: value[sortedValue],
                  color: Colors.green.shade400,
                );
                stepWidgets.add(step);
              } else {
                var step = ExplanationCard(
                  step: value[sortedValue],
                  color: Colors.white30,
                );
                stepWidgets.add(step);
              }
            }
          });
        }
      });
    });
  }
}
