import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key? key,
      required this.question,})
      : super(key: key);

  //Title of question
  final String question;

  @override
  Widget build(BuildContext context) {
    return Center(
            child: SingleChildScrollView(
                child: Container(
                    alignment: Alignment.topCenter,
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Column(children: <Widget>[
                          Text(question,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ])
                    ))
            ));
  }
}
