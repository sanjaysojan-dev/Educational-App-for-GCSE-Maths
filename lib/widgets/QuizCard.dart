import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String imageURL;

  const QuizCard({required this.title, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return
    ClipRRect(
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
                        color: Colors.black87,
                        fontWeight: FontWeight.w400)),
              ]
          ),
        )
    );
  }
}
