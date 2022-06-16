import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app_for_maths/models/UserModel.dart';
import 'package:educational_app_for_maths/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final forenameEditingController = new TextEditingController();
  final surnameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPassEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //
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
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Forname",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //
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
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Surname",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //
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
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //
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
          prefixIcon: Icon(Icons.key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //
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
          prefixIcon: Icon(Icons.password_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //
    final registrationButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          register(
              emailEditingController.text, confirmPassEditingController.text);
        },
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
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
                      registrationButton
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }


  void register(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password).
      then((value) => {
      postDataToFirestore()
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDataToFirestore() async {
    // calls firestore
    // calls user model
    // sending value

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.forename = forenameEditingController.text;
    userModel.surname = surnameEditingController.text;

    await firebaseFirestore.collection("users")
        .doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
    => HomeScreen()), (route) => false);
  }

}
