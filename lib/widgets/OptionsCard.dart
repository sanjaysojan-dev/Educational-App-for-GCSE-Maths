import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.option,
    required this.color,
  }) : super(key: key);

  //Title of option
  final String option;

  //Colour of option depending on selection
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
                option,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: color == Colors.yellow.shade400? Colors.black : Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          color: color,
        ));
  }
}
