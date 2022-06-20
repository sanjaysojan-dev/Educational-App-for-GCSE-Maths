import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/screens/ForgotPasswordScreen.dart';
import 'package:educational_app_for_maths/screens/RegistrationScreen.dart';
import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key - helps validating the email and password
  // uniquely identifies a form
  final _formKey = GlobalKey<FormState>();

  //controllers for editing email/password fields
  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    //email field
    final email = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        }

        //Checking if input conforms to regular expression
        // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
        //   return "Please enter a valid email";
        // }
      },
      //validator: () {},
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');

        if (value!.isEmpty) {
          return "Please enter your password";
        }

        if (!regex.hasMatch(value)) {
          return "Please enter valid password with minimum of\n 8 characters";
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    final googleSignInButton = SignInButton(
      Buttons.Google,
      onPressed: () {
        signInWithGoogle();

      },
    );

/* returns a scaffold in which creates body in which contains the
*  the form with the email and password fields.
*
* */
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 200,
                    //   child: Image.asset(''
                    //   , fit: BoxFit.contain
                    //   )),
                    SizedBox(height: 45),
                    email,
                    SizedBox(height: 25),
                    password,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    googleSignInButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Log in successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn();

      if (googleSignInAccount != null) {
        //
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        //
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        //
        await _auth.signInWithCredential(authCredential);

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        User? user = FirebaseAuth.instance.currentUser;
        firebaseFirestore.collection(user!.uid).where(
            "email", isEqualTo: user!.email).get();


        if (await checkIfDocExists("users",user!.uid) == false) {
          
          UserModel userModel = UserModel();
          userModel.email = user!.email;
          userModel.uid = user!.uid;
          userModel.displayName = user.displayName;

          await firebaseFirestore.collection("users")
              .doc(userModel.uid).set(userModel.toMap());
        }
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e!.message.toString());
    }
  }



  Future <bool> checkIfDocExists (String collection, String document ) async {
    try {

      var collectionRef = FirebaseFirestore.instance.collection(collection);
      var doc = await collectionRef.doc(document).get();
      print(doc.exists);
      return doc.exists;

    }on FirebaseAuthException catch (e){
      return false;
    }
  }

}
