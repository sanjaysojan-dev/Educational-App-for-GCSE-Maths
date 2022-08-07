import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/screens/LoginScreen.dart';
import 'package:educational_app_for_maths/widgets/QuizCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:educational_app_for_maths/utils/FirestoreUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _googleSignIn = GoogleSignIn();

  FirestoreUtil firestoreUtil = new FirestoreUtil();

  Stream? quizStream;

  @override
  void initState() {
    firestoreUtil.getQuizTopics().then((value) {
      setState(() {
        quizStream = value;

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text("GCSE Maths App",
            style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
            onPressed: () {
              // passing this to our root
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
            }),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => selectionTab(context, item),
              itemBuilder: (context) =>
                  [PopupMenuItem<int>(value: 0, child: Text("Sign Out", style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),)),
                    PopupMenuItem<int>(value: 1, child: Text("Delete Account", style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold)))
                  ])
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: StreamBuilder(
            stream: quizStream,
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
                          quizID:(snapshot!.data as QuerySnapshot)
                              .docs[index]
                              .get("quizID") ,
                        );


                      //print(ref.toString());
                      //return Container();
                      });
            }),
      )),
    );
  }

  /// A method to log out user from application
  ///
  /// context: link to widget tree
  /// Returns a Future due to async method
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();

    SharedPreferences.getInstance().then((preference) {
      preference.clear();
    });

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  /// A method to delete user account
  ///
  /// context: link to widget tree
  ///  Returns a Future due to async method
  Future<void> deleteAccount(BuildContext context) async {
    try {

      SharedPreferences.getInstance().then((preference) {
        preference.clear();
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .delete();

      await FirebaseAuth.instance.currentUser!.delete();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {

        print('The user must reauthenticate before this operation can be executed.');
      }
    }


  }

  /// A method to select method based on popupmenu item selection.
  ///
  /// item: selected menu number
  void selectionTab(BuildContext context, int item) {
    switch (item) {
      case 0:
        logout(context);
        break;
      case 1:
        deleteAccount(context);
        break;
    }
  }
}
