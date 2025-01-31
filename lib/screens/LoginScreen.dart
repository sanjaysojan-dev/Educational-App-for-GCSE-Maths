import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/screens/ForgotPasswordScreen.dart';
import 'package:educational_app_for_maths/screens/RegistrationScreen.dart';
import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserModel.dart';
import '../utils/FirestoreUtil.dart';

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

  //Google Sign in Instance
  final _googleSignIn = GoogleSignIn();

  //Terms and Condition Text Span
  final _termsAndConditions = Text.rich(TextSpan(
      text: "By signing up, you agree to the ",
      style: TextStyle(color: Colors.blue.shade900, fontSize: 10),
      children: <TextSpan>[
        TextSpan(
            text: "Terms and Conditions",
            style: TextStyle(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                decoration: TextDecoration.underline),
            recognizer:  new TapGestureRecognizer()..onTap = (){})
      ]));

  bool isChecked = false;

  @override
  void initState() {
    loadLoginInfo();
    super.initState();
  }

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
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //password field
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        //Minimum number of characters is 6
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
          prefixIcon: Icon(Icons.key, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //login in Material Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.yellow,
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    //Google Sign in Button - Accessed through external library
    final googleSignInButton = SignInButton(
      Buttons.Google,
      onPressed: () {
        signInWithGoogle();
      },
    );

    //Found in documentation
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black26;
      }
      return Colors.yellow.shade700;
    }

    //Checkbox to remember login details
    final rememberMeCheckBox = Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: rememberLoginDetails,
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
                  // Main Axis Alignment determines how Row and Column can position
                  // their children in that space.

                  //Positions children at the middle of the main axis.
                  mainAxisAlignment: MainAxisAlignment.center,

                  //A Row’s cross axis is vertical, and a Column’s cross axis is
                  // horizontal.

                  //Positions children at the middle of the cross axis.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //A box with a specified size. - If given a child, this widget
                    // forces it to have a specific width and/or height.
                    SizedBox(height: 45),
                    email,
                    SizedBox(height: 25),
                    password,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                rememberMeCheckBox,
                                Text(
                                  "Remember Me",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                )
                              ]),
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
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ]),
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
                          child: Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    googleSignInButton,
                    SizedBox(height: 120),
                    Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Flexible(child: _termsAndConditions)]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// A method to sign in using user email and password through
  /// Firebase Authentication.
  ///
  /// email: user email to account
  /// password: user password to account
  ///
  void signIn(String email, String password) async {
    var preferences = SharedPreferences.getInstance();

    if (isChecked) {
      preferences.then((preference) {
        preference.setBool("checkBox", isChecked);
        preference.setString("email", emailController.text);
        preference.setString("password", passwordController.text);
      });
    }

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

  ///A method to sign through the Google Sign in interface
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      //since Google Sign In Account can be nullable you conduct a check
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

        registerGoogleUser();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e!.message.toString());
    }
  }

  /// A method to add Google Signed in users to the user firestore collection
  void registerGoogleUser() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      firebaseFirestore
          .collection(user!.uid)
          .where("email", isEqualTo: user!.email)
          .get();

      if (await FirestoreUtil.checkIfDocExists("users", user!.uid) == false) {
        UserModel userModel = UserModel();
        userModel.email = user!.email;
        userModel.uid = user!.uid;
        userModel.displayName = user.displayName;

        await firebaseFirestore
            .collection("users")
            .doc(userModel.uid)
            .set(userModel.toMap());
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e!.message.toString());
    }
  }

  ///A method to set user login details to shared preferences
  ///Sets value of isChecked
  void rememberLoginDetails(bool? value) {
    isChecked = value!;

    if (isChecked == true) {
      SharedPreferences.getInstance().then((preference) {
        preference.setBool("checkBox", value);
        preference.setString("email", emailController.text);
        preference.setString("password", passwordController.text);
      });
    } else {
      SharedPreferences.getInstance().then((preference) {
        preference.clear();
      });
    }

    setState(() {
      isChecked = value;
    });
  }

  ///A method to load user details when logging in from shared preferences
  ///Sets value of isChecked
  void loadLoginInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var checkBox = preferences.getBool("checkBox");

    if (checkBox != null) {
      setState(() {
        isChecked = true;
        emailController.text = preferences.getString("email").toString();
        passwordController.text = preferences.getString("password").toString();
      });
    }
  }
}
