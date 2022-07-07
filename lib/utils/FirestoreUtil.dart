import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreUtil {
  getQuizQuestions() async {
    return await FirebaseFirestore.instance
        .collection("quiz_questions")
        .snapshots();
  }

  getSpecificQuestions() async {

    Map<String, dynamic>? test;
    var db = await FirebaseFirestore.instance.collection("quiz_questions/Algebra_1/questions");
    db.doc("question_1").get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        test = documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('Document does not exist on the database');
      }
    });

    return test;
  }
}
