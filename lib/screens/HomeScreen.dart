import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/UserModel.dart';
import 'package:educational_app_for_maths/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();



  @override
  void initState () {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid).get()
        .then((value){
          this.userModel = UserModel.fromMap(value.data());
          setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GCSE Maths Educational App"),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          // SizedBox(
          //   height: 200,
          //   child: Image.asset(''
          //   , fit: BoxFit.contain
          //   )),],
            Text("${userModel.forename} ${userModel.surname}", style: TextStyle (fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10 ,),
            Text ("${userModel.email}", style:  TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),),
            SizedBox(height: 15),
            ActionChip(label: Text( "Logout", style: TextStyle(color:Colors.black45, fontWeight: FontWeight.bold),),
                avatar: Icon(Icons.logout, color: Colors.black45,),
                onPressed: (){
              logout(context);
                })

          ]
        ),
      )
      ),
    );
  }


  Future<void> logout (BuildContext context) async {
    await FirebaseAuth.instance.signOut();Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
    => LoginScreen()), (route) => false);
  }
}
