import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class ExplanationCard extends StatelessWidget {

  ExplanationCard({
    Key? key,
    required this.step,
    required this.color,
  }) : super(key: key);

   final String step;
   final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 80,
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(step),
            ],
          ),
          color: color,
        ));
  }
}
