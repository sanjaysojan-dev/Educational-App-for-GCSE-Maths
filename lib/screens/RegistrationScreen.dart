import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/FirestoreUtil.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;

  FirestoreUtil firestoreUtil = new FirestoreUtil();

  final _formKey = GlobalKey<FormState>();

  final forenameEditingController = new TextEditingController();

  final surnameEditingController = new TextEditingController();

  final emailEditingController = new TextEditingController();

  final passwordEditingController = new TextEditingController();

  final confirmPassEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Forename Field
    final forenameField = TextFormField(
      autofocus: false,
      controller: forenameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Forename cannot be empty";
        }
      },
      onSaved: (value) {
        forenameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Forename",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //Surname Field
    final surnameField = TextFormField(
      autofocus: false,
      controller: surnameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Surname cannot be empty";
        }
      },
      onSaved: (value) {
        surnameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Surname",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //Email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email cannot be empty";
        }
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //Password Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{8,}$');

        if (value!.isEmpty) {
          return "Please enter your password";
        }

        if (!regex.hasMatch(value)) {
          return "Please enter valid password with minimum of\n 8 characters";
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.key, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //Confirmation Password Field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPassEditingController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Name cannot be empty";
        } else if (confirmPassEditingController.text != value) {
          return "Password must match";
        }
      },
      onSaved: (value) {
        confirmPassEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.password_outlined, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    // Registration Material Button
    final registrationButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.yellow,
      child: MaterialButton(
        onPressed: () {
          registerAccount(
              emailEditingController.text, confirmPassEditingController.text);
        },
        child: Text(
          "Register",
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            }),
      ),
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
                      SizedBox(height: 25),
                      forenameField,
                      SizedBox(height: 25),
                      surnameField,
                      SizedBox(height: 25),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 25),
                      confirmPasswordField,
                      SizedBox(height: 25),
                      registrationButton,
                      SizedBox(height: 70),
                      Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [Flexible(child: _termsAndConditions)]))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  ///A method to create new user through Firebase Authentication
  ///
  /// email: user email
  /// password: confirmed password
  void registerAccount(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => {
                await firestoreUtil.postDataToFirestore(
                    forenameEditingController.text,
                    surnameEditingController.text),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false)
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
