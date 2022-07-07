import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class MCQuizScreen extends StatefulWidget {

  //const MCQuizScreen({Key? key}) : super(key: key);

  final String quizID;
  MCQuizScreen(this.quizID);


  @override
  _MCQuizScreenState createState() => _MCQuizScreenState();
}

class _MCQuizScreenState extends State<MCQuizScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // passing this to our root
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        title: Text("GCSE Maths Educational App",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        centerTitle: true,
      ),
    );
  }








}
