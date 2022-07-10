import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:educational_app_for_maths/widgets/NextQuestionButton.dart';
import 'package:educational_app_for_maths/widgets/OptionsCard.dart';
import 'package:educational_app_for_maths/widgets/QuestionCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  int index = 0;

  bool onPressed = false;

  onSelection() {
    setState(() {
      onPressed = true;
    });
  }

  _MCQuizScreenState(this._questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // passing this to our root
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.help), color: Colors.black, onPressed: () {})
        ],
        title: Text("GCSE Maths Educational App",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Container(
            //padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              //A Row’s cross axis is vertical, and a Column’s cross axis is
              // horizontal.

              //Positions children at the middle of the cross axis.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                QuestionCard(question: _questions[index].question),
                for (int i = 0; i < _questions[index].options.length; i++)
                  Column(children: <Widget>[
                    SizedBox(height: 20),
                    OptionsCard(
                      option: _questions[index].options.keys.toList()[i],
                      color: onPressed
                          ? _questions[index].options.values.toList()[i] == true
                              ? Colors.green.shade700
                              : Colors.red.shade700
                          : Colors.yellow,
                      onPressed: onSelection,
                    )
                  ]),
                SizedBox(height: 20),
                NextQuestionButton(nextQuestion: nextIndex),

                //questionExtraction()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  colorPicker(bool value) {
    return value ? Colors.green.shade700 : Colors.red.shade700;
  }

  void nextIndex() {
    if (index != _questions.length - 1) {
      if (onPressed){
      setState(() {
        onPressed = false;
        index++;
      });
      } else {
        Fluttertoast.showToast(msg: "Please select an Option");
      }
    }
  }
}
