import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class QuizWorkingScreen extends StatefulWidget {
  @override
  _QuizWorkingScreenState createState() => _QuizWorkingScreenState();
}

class _QuizWorkingScreenState extends State<QuizWorkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.yellow.shade700,
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // passing this to our root
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
            => HomeScreen()), (route) => false);
          }),
      actions: [

      ],
      title: Text("Workings",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
      centerTitle: true,
    ));
  }
}
