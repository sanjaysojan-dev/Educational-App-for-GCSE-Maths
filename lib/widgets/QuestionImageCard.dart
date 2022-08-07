import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionImageCard extends StatelessWidget {
  const QuestionImageCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  //Online link to image
  final String image;

  //If question has no image then empty container is returned
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
