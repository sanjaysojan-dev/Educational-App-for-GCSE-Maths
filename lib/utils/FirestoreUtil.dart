import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/QuestionModel.dart';
import 'package:educational_app_for_maths/models/ScoreModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/UserModel.dart';

class FirestoreUtil {
  late List<QuestionModel> _questions = <QuestionModel>[];

  List<QuestionModel> get questions => _questions;

  ScoreModel userScores =  ScoreModel();

  final _auth = FirebaseAuth.instance;

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


  ///A method to register user to the firestore user collection
  /// If completed successfully then application transistions to home page
  Future postDataToFirestore(String forename, String surname) async {
    // calls firestore
    // calls user model
    // sending value

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.displayName =
        forename + " " + surname;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created");

  }

  ///A method to obtain the quiz topic available in Firestore
  ///
  /// Returns query snapshot
  getQuizTopics() async {
    return await FirebaseFirestore.instance
        .collection("quiz_questions")
        .snapshots();
  }

  ///A method to retrieve all questions for a selected topic.
  ///The questions are mapped to a model and stored in a
  ///questions List.
  ///
  /// questionID: selected question ID
  ///
  /// Returns query snapshot
  getTopicQuestions(String questionID) async {
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

  /// A method to set the score of the quiz.
  ///
  /// questionsID
  setScore(String quizTopicID, int score) {
    try {
      FirebaseFirestore.instance
          .doc("users/" + currentUser!.uid)
          .update({"quiz_scores." + quizTopicID: score});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

///Obtains the score of the user for all quiz attempts
  getScores() async {
    var db = await FirebaseFirestore.instance.doc("users/" + currentUser!.uid);
    db.get().then((value) => {
      userScores.setScores = Map<String, dynamic>.from(value.get("quiz_scores"))
    });
    return db.snapshots();
  }

}
