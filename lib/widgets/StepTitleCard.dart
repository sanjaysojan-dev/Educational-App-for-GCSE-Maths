import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepTitleCard extends StatelessWidget {
  StepTitleCard({Key? key, required this.title}) : super(key: key);

  //Title of solution step
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(children: <Widget>[
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(
                    Icons.lightbulb,
                    color: Colors.amber,
                  )),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: FittedBox(
                      child: Text(
                title,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              )))
            ])));
  }
}
