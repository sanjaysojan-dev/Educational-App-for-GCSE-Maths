import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:educational_app_for_maths/utils/FirestoreUtil.dart';
import 'package:educational_app_for_maths/widgets/NextQuestionButton.dart';
import 'package:educational_app_for_maths/widgets/OptionsCard.dart';
import 'package:educational_app_for_maths/widgets/QuestionCard.dart';
import 'package:educational_app_for_maths/widgets/QuestionImageCard.dart';
import 'package:educational_app_for_maths/widgets/ResultsDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/QuestionModel.dart';

class MCQuizScreen extends StatefulWidget {

  //List to store questions of quiz topic
  List<QuestionModel> _questions = <QuestionModel>[];

  //Quiz ID
  String quizID = "";

  MCQuizScreen(this._questions, this.quizID);

  @override
  _MCQuizScreenState createState() => _MCQuizScreenState(_questions,quizID);
}

class _MCQuizScreenState extends State<MCQuizScreen> {
  FirestoreUtil firestoreUtil = new FirestoreUtil();
  
  List<QuestionModel> _questions;

  String quizID;

  int index = 0;

  int score = 0;

  bool onPressed = false;

  _MCQuizScreenState(this._questions,this.quizID);


  ///Sets state of onPressed for option selected
  onSelection() {
    setState(() {
      onPressed = true;
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.help),
              color: Colors.blue.shade900,
              onPressed: () {
                Fluttertoast.showToast(msg: _questions[index].hint);
              })
        ],
        title: Text("Score: " '$score',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Container(
            //padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              //A Row’s cross axis is vertical, and a Column’s cross axis is
              // horizontal.

              //Positions children at the middle of the cross axis.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                QuestionCard(question: _questions[index].question),
                QuestionImageCard(image: _questions[index].image),
                for (int i = 0; i < _questions[index].options.length; i++)
                  Column(children: <Widget>[
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () => scoreCalculation(index, i),
                        child: OptionsCard(
                          option: _questions[index].options.keys.toList()[i],
                          color: colorPicker(index, i),
                        )),
                  ]),
                SizedBox(height: 20),
                NextQuestionButton(nextQuestion: nextIndex,buttonTitle: "Next Question "),

                //questionExtraction()
              ],
            ),
          ),
        ),
      ]),
    );
  }


  /// A method to calculate the score based on the
  /// option selected by the user. If the selected option
  /// is false score is not updated. Sets the state of
  /// the application to true.
  ///
  /// index: position of the question in list
  /// option: selected option
  scoreCalculation(int index, int option) {
    if (_questions[index].options.values.toList()[option] &&
        onPressed == false) {
      score++;
      Fluttertoast.showToast(
          msg: "Well done! Correct Answer",
          backgroundColor: Colors.blue.shade900,
          textColor: Colors.white);
    } else if (!_questions[index].options.values.toList()[option] &&
        onPressed == false) {
      Fluttertoast.showToast(
          msg: "Not quite right",
          backgroundColor: Colors.blue.shade900,
          textColor: Colors.white);
    }

    setState(() {
      onPressed = true;
    });
  }

  /// A method to select the color based on the
  /// option selected by the user. If the selected option
  /// is false then the colour red is return otherwise,
  /// green. If no option is selected then colour yellow
  /// remains.
  ///
  /// index: position of the question in list
  /// option: selected option
  Color colorPicker(int index, int option) {
    if (onPressed) {
      if (_questions[index].options.values.toList()[option] == true) {
        return Colors.green.shade400;
      } else {
        return Colors.red.shade400;
      }
    } else {
      return Colors.yellow.shade400;
    }
  }

  ///A method to increment counter and update question.
  ///Checks to see if the an option has been selected.
  void nextIndex() {
    if (index != _questions.length - 1) {
      if (onPressed) {
        setState(() {
          onPressed = false;
          index++;
        });
      } else {
        Fluttertoast.showToast(msg: "Please select an Option");
      }
    } else if (index == _questions.length - 1) {
      if (onPressed) {
        showDialog(
            context: context,
            builder: (ctx) => ResultsDialog(
              totalNumQuestions: _questions.length,
              score: score,
              resetQuiz: resetQuiz,
              questions: _questions,
            ));
        firestoreUtil.setScore(quizID, score);
      } else {
        Fluttertoast.showToast(msg: "Please select an Option");
      }
    }
  }

  /// A method to reset counter and quiz state.
  void resetQuiz(){
    setState(() {
      onPressed = false;
      index = 0;
      score = 0;
    });
  }
}
