import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen ({Key? key}): super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State <RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();

  final forenameEditingController = new TextEditingController();
  final surnameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPassEditingController = new TextEditingController();




  @override
  Widget build (BuildContext context) {

    //
    final forenameField = TextFormField(
      autofocus: false,
      controller: forenameEditingController,
      keyboardType: TextInputType.name,
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
        onPressed: () {},
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight:
              FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: (){
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
                    )
                ),
              ),
            ),
          ),
        ),
      );
  }
}