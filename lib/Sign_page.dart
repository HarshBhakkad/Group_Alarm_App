import 'package:alarm_app/HomeScreen.dart';
import 'package:alarm_app/main.dart';
import 'package:flutter/material.dart';
import 'Log_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:form_validator/form_validator.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _email = TextEditingController(text: '');

  TextEditingController _password = TextEditingController(text: '');

  TextEditingController _confirm_password = TextEditingController(text: '');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int flag_signup_form = 0;

  Future SignUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      flag_signup_form = 1;
      return;
    } else {
      flag_signup_form = 0;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Create an Account,Its free",
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
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _email,
                                  validator: (value) {
                                    if (value != null &&
                                        EmailValidator.validate(value)) {
                                      return null;
                                    } else {
                                      return 'Please enter a valid email';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "E-mail",
                                  ),
                                ),
                                TextFormField(
                                  controller: _password,
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
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 10, 8, 20),
                                  child: TextFormField(
                                    controller: _confirm_password,
                                    // initialValue: ".",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Password cannot be empty';
                                      } else {
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        if (value != _password.text) {
                                          return 'Password does not match';
                                        }
                                        return null;
                                      }
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          onPressed: () async {
                            SignUp();
                            if (flag_signup_form == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                              );
                            } else {
                              return;
                            }
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
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
                        Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Login",
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
      ),
    );
  }
}
