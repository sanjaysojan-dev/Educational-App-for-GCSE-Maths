import 'package:educational_app_for_maths/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Email field
    final email = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email ";
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.yellow.shade600),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade900, width: 2.5))),
    );

    //Reset Password Button
    final resetPasswordButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.yellow.shade600,
        child: MaterialButton(
          onPressed: () {
            passwordReset(emailController.text);
          },
          child:  Text(
            'RESET PASSWORD ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.blue.shade900, fontWeight: FontWeight.bold),
          ),
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back,
            color: Colors.blue.shade900,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 0, 36, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Text(
                          "RESET YOUR PASSWORD",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Text(
                          "Type in your email address and "
                          "we'll send you an email to create a new password.",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ))
                      ],
                    ),
                    SizedBox(height: 15),
                    email,
                    SizedBox(height: 15),
                    resetPasswordButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  ///A method to reset the password of an account using Firebase Authentication
  ///email: email of user
  ///
  ///Returns a 'Future'
Future passwordReset (String email ) async {
    if (_formKey.currentState!.validate()) {

      try {
        await _auth.sendPasswordResetEmail(email: email);
        Fluttertoast.showToast(msg: "Password reset link sent");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));

      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e!.message.toString());
      }
    }
}

}
