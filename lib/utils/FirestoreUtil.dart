import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirestoreUtil{


 getQuizQuestions () async {
    return await FirebaseFirestore.instance.collection("quiz_questions").snapshots();
  }





}