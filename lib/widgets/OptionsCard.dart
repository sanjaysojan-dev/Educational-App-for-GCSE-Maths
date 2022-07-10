import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.option,
  }) : super(key: key);

  final String option;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          Text(
             option,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow,
        fixedSize: Size(350, 10)// Background color
      ),
      onPressed: (){},
    );;
  }
}
