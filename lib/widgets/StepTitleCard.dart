import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/FirestoreUtil.dart';

class StepTitleCard extends StatelessWidget {
  StepTitleCard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: Row(children: <Widget>[
          Icon(Icons.lightbulb, color: Colors.amber,),
          SizedBox(width: 10,),
          Flexible(child: FittedBox(
                  child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
          )))
       

        ]));
  }
}
