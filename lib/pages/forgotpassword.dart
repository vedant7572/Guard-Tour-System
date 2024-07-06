import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gts/pages/signup.dart';

import 'login.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailController = TextEditingController();

  String email = "";

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Password Reset Email has been sent !",
            style: TextStyle(fontSize: 18.0),
          )
      )
      );
    }
    on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "No user found for that email.",
                style: TextStyle(fontSize: 18.0)
            )
        )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF008FB8),
                Color(0xFF005F80),
              ],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

              SizedBox(
                height: 70.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  "Password Recovery",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),//password recovery text

              const SizedBox(
                height: 10.0,
              ),

              const Text(
                "Enter your mail",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),//enter email text

              Expanded(
                  child: Form(
                      key: _formkey,

                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),

                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),

                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextFormField(
                                controller: mailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    hintStyle:
                                    TextStyle(fontSize: 18.0, color: Colors.white),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),

                            SizedBox(
                              height: 50.0,
                            ),
                            GestureDetector(
                              onTap: (){
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email= mailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: Container(
                                width: 140,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Send Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Login()
                                    )
                                );
                              },
                              child: Container(
                                width: 140,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Go to Login Page",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                                ),

                                const SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  },
                                  child: const Text(
                                    "Create",
                                    style: TextStyle(
                                        color: Color.fromARGB(225, 184, 166, 6),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )

                          ],
                        ),
                      ))),
            ],
          ),
        )

    );
  }
}
