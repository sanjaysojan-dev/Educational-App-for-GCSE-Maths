import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class QuestionImageCard extends StatelessWidget {
  const QuestionImageCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return image == "empty" ? Container() :
    Container(
        child:
        Image.network(
          image,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.cover,
        )
    );
  }
}
