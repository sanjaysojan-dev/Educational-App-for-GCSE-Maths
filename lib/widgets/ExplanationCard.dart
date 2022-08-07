import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExplanationCard extends StatelessWidget {
  ExplanationCard({
    Key? key,
    required this.step,
    required this.color,
  }) : super(key: key);

  //Explanation of step
  final String step;

  //Colour of explanation card
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
              Text(
                step,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          color: color,
        ));
  }
}
