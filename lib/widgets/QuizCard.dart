import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String imageURL;
  final String quizID;
  FirestoreUtil firestoreUtil = new FirestoreUtil();

  QuizCard({required this.title, required this.quizID, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {

          await firestoreUtil.getSpecificQuestions(quizID);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MCQuizScreen(firestoreUtil.questions)));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              height: 150,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Image.network(
                  imageURL,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ]),
            )));
  }
}
