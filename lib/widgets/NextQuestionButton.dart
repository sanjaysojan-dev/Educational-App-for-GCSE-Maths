import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextQuestionButton extends StatelessWidget {
  NextQuestionButton({required this.nextQuestion, required this.buttonTitle});

  //Title of button
  final String buttonTitle;

  //Next Question
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
        primary: Colors.black26, // Background color
      ),
      onPressed: nextQuestion,
    );
  }
}
