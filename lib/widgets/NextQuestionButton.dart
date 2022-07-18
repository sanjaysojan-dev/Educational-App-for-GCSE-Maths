import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class NextQuestionButton extends StatelessWidget {
  NextQuestionButton({required this.nextQuestion, required this.buttonTitle});

  final String buttonTitle;
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          Text( this.buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.arrow_right_alt_outlined,
            color: Colors.black,
          )
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow, // Background color
      ),
      onPressed: nextQuestion,
    );
  }
}
