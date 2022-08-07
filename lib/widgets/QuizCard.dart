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


  /// Widget builder uses FutureBuilder to wait for topic questions be returned
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: firestoreUtil.getTopicQuestions(quizID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          MCQuizScreen(firestoreUtil.questions, title)));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 200,
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        Image.network(
                          imageURL,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color:Colors.black,
                                fontWeight: FontWeight.w700)),
                      ]),
                    )));
            return Center(
                child: Container(child: Text('hasData: ${snapshot.data}')));
          } else {
            return Center (child:
            SizedBox(
                child: CircularProgressIndicator(),
              height: 200,
              width: 200,
            ));
          }
        },
      );
}
