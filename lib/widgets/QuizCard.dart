import 'package:educational_app_for_maths/screens/MCQuizScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String imageURL;
  final String quizID;

  const QuizCard({required this.title, required this.imageURL, required this.quizID});

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
        onTap: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MCQuizScreen(this.quizID)));
        },
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child:
      Container(
        height: 150,
          child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(imageURL, width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ]
          ),
        )
    )
    );
  }
}
