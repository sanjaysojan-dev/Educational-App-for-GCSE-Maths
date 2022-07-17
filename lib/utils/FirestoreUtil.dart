import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreUtil {

  late List<QuestionModel> _questions = <QuestionModel>[];


  getQuizQuestions() async {
    return await FirebaseFirestore.instance
        .collection("quiz_questions")
        .snapshots();
  }


  getSpecificQuestions(String questionID) async {


    var db = await FirebaseFirestore.instance.collection("quiz_questions/"+ questionID +"/questions");
    db.get().then((QuerySnapshot querySnapshot) {

     if (querySnapshot.docs.isEmpty == false){
         querySnapshot.docs.forEach((doc) {

           QuestionModel question = QuestionModel();
           question.setQuestionTitle = doc["question"];
           question.setQuestionHint =  doc["hint"];
           question.setImage = doc["image"];
           question.setQuestionOptions = Map<String, dynamic>.from(doc["options"]);
           question.setSolutions =  Map<String, Map<String, dynamic>>.from(doc["solutions"]);
           _questions.add(question);
         });
     } else {
       print('Document does not exist on the database');
     }
    });

    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //     test = documentSnapshot.data() as Map<String, dynamic>?;
    //   } else {
    //     print('Document does not exist on the database');
    //   }
    // });

    return db.snapshots();
  }

  List<QuestionModel> get questions => _questions;




}
