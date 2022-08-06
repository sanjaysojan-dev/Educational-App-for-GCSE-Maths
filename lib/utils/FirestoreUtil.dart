import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/models/ScoreModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUtil {
  late List<QuestionModel> _questions = <QuestionModel>[];

  List<QuestionModel> get questions => _questions;
  ScoreModel userScores =  ScoreModel();
  var currentUser = FirebaseAuth.instance.currentUser;




  ///A method to check if Googled Signed in user has already been registed
  ///in the user firestore collection
  ///
  /// collection: collection that needs to be accessed
  /// document: the document that needs to be accessed
  ///
  /// Returns a boolean variable: True if document exists, false otherwise
  static Future<bool>  checkIfDocExists(String collection, String document) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection(collection);
      var doc = await collectionRef.doc(document).get();
      print(doc.exists);
      return doc.exists;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }


  getQuizQuestions() async {
    return await FirebaseFirestore.instance
        .collection("quiz_questions")
        .snapshots();
  }

  getSpecificQuestions(String questionID) async {
    var db = await FirebaseFirestore.instance
        .collection("quiz_questions/" + questionID + "/questions");

    db.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty == false) {
        querySnapshot.docs.forEach((doc) {
          QuestionModel question = QuestionModel();
          question.setQuestionTitle = doc["question"];
          question.setQuestionHint = doc["hint"];
          question.setImage = doc["image"];
          question.setQuestionOptions =
              Map<String, dynamic>.from(doc["options"]);
          question.setSolutions =
              Map<String, Map<String, dynamic>>.from(doc["solutions"]);
          _questions.add(question);
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    return db.snapshots();
  }

  setScore(String questionID, int score) {
    try {
      FirebaseFirestore.instance
          .doc("users/" + currentUser!.uid)
          .update({"quiz_scores." + questionID: score});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getScores() async {

    var db = await FirebaseFirestore.instance.doc("users/" + currentUser!.uid);
    //userScores = ScoreModel();

    db.get().then((value) => {

      userScores.setScores = Map<String, dynamic>.from(value.get("quiz_scores"))

    });

    return db.snapshots();

  }

}
