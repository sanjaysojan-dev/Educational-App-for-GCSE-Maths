import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../models/QuestionModel.dart';

class MCQuizScreen extends StatefulWidget {

  //const MCQuizScreen({Key? key}) : super(key: key);

  List<QuestionModel> _questions = <QuestionModel>[];

  MCQuizScreen(this._questions);


  @override
  _MCQuizScreenState createState() => _MCQuizScreenState(_questions);
}

class _MCQuizScreenState extends State<MCQuizScreen> {

  List<QuestionModel> _questions;
  _MCQuizScreenState(this._questions);

   late var questionTitle;

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

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                //A Row’s cross axis is vertical, and a Column’s cross axis is
                // horizontal.

                //Positions children at the middle of the cross axis.
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45),
                  questionExtraction ()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


Widget questionExtraction (){

    //_questions[0].question;

    print(_questions.length);
    return Text(_questions[0].question);

}





}
