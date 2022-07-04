import 'package:email_validator/email_validator.dart';
import 'package:alarm_app/main.dart';
import 'package:flutter/material.dart';
import 'Sign_page.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_validator/form_validator.dart';
import 'HomeScreen.dart';
import 'package:alarm_app/globals.dart' as globals;

class LoginPage extends StatelessWidget {
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password_ = TextEditingController();
  // String _errorMessagepass = '';
  // String _errorMessageemail = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int flag_login_form = 0;

  Future SignIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      flag_login_form = 1;
      return;
    }
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailAddress.text,
        password: _password_.text,
      );
      globals.alarm_cards.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // _errorMessageemail = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        // _errorMessagepass = 'Wrong password provided for that user.';

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/alarm_clock.png'))),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome back ! Login with your credentials",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value != null &&
                                  EmailValidator.validate(value)) {
                                return null;
                              } else {
                                return 'Please enter a valid email';
                              }
                            },
                            controller: _emailAddress,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Password cannot be empty';
                              } else {
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              }
                            },
                            controller: _password_,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          SignIn();
                          if (flag_login_form == 1) {
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                          }
                        },
                        color: Colors.indigoAccent[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
