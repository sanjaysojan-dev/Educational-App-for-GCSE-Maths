import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/UserModel.dart';
import 'package:educational_app_for_maths/screens/LoginScreen.dart';
import 'package:educational_app_for_maths/widgets/QuizCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:educational_app_for_maths/utils/FirestoreUtil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _googleSignIn = GoogleSignIn();
  var userName = Text("");
  var userEmail = Text("");

  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  FirestoreUtil firestoreUtil = new FirestoreUtil();
  Stream? quizStream;
  Stream? questionStream;

  @override
  void initState() {
    // firestoreUtil.getQuizQuestions().then((value) {
    //   setState(() {
    //     quizStream = value;
    //
    //   });
    // });
    firestoreUtil.getSpecificQuestions().then((value) {
        setState(() {
          questionStream = value;
        });
      });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text("GCSE Maths Educational App",
            style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // passing this to our root
              logout(context);
            }),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => selectedTab(context, item),
              itemBuilder: (context) =>
                  [PopupMenuItem<int>(value: 0, child: Text("Sign Out"))])
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: StreamBuilder(
            stream: questionStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20,);
                  },
                      itemCount: (snapshot!.data as QuerySnapshot).size,
                      itemBuilder: (context, index) {


                        return QuizCard(
                            title: (snapshot!.data as QuerySnapshot)
                                .docs[index]
                                .get("title"),
                            imageURL: (snapshot!.data as QuerySnapshot)
                                .docs[index]
                                .get("imageURL"),
                        quizID: (snapshot!.data as QuerySnapshot)
                            .docs[index]
                            .get("quizID"),);


                      //print(ref.toString());
                      //return Container();
                      });
            }),
      )),
    );
  }


  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  void selectedTab(BuildContext context, int item) {
    switch (item) {
      case 0:
        logout(context);
        break;
      case 1:
        break;
    }
  }
}
