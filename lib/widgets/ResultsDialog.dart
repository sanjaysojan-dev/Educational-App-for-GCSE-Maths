import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:educational_app_for_maths/screens/QuizWorkingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class ResultsDialog extends StatelessWidget {
  ResultsDialog({required this.totalNumQuestions, required this.score, required this.resetQuiz});

  final int totalNumQuestions;
  final int score;
  final VoidCallback resetQuiz;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Results'),
      backgroundColor: Colors.white,
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
                height: 70,
                width: 150,
                color: colorPicker(),
                child: Stack(
                    alignment: Alignment.center, children: <Widget>[
                  SizedBox(height: 50),
                  Text(score.toString() + "/" + totalNumQuestions.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ])

            ),
          ),
          SizedBox(height: 20),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            resetQuiz();
          },
          child: Text('Start over?', style: TextStyle(
            color: Colors.black87
          ),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
            => QuizWorkingScreen()), (route) => false);
          },
          child: Text('Show Workings'),
        ),
      ],
    );
  }


  Color colorPicker() {
    if (score == totalNumQuestions) {
      return Colors.green;
    } else if (score < totalNumQuestions) {
      if (score == 0) {
        return Colors.red;
      }
      return Colors.yellow;
    }
    return Colors.black12;
  }

}

