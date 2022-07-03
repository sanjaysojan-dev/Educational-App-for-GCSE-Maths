import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {


  final String title;
  final String imageURL;

  const QuizCard({required this.title, required this.imageURL});


  @override
  Widget build(BuildContext context) {
    return Container(child: Stack(
      children: [
        Image.network(imageURL),
        Text(
            title,
          textAlign: TextAlign.center,
          style:TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold)
        )
      ],
    ),);
  }

}

