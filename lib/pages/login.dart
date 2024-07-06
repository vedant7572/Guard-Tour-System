import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gts/pages/signup.dart';

import '../service/database.dart';
import '../service/shared_pref.dart';
import '../widget_support/text_style.dart';
import 'bottomnav.dart';
import 'forgotpassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = "", password = "";

  final _formkey= GlobalKey<FormState>();

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Login Successful",
                style: TextStyle(fontSize: 20.0),
              )
          )
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavbar()
          )
      );
    }
    on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = "No User Found for that Email";
      }
      else if (e.code == 'wrong-password') {
        message = "Wrong Password Provided by User";
      }
      else {
        message = "An error occurred. Please try again.";
      }


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                message,
                style: const TextStyle(fontSize: 18.0, color: Colors.black),
              )
          )
      );
    }
  }


  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),//white part
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                  height: MediaQuery.of(context).size.height /1.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF008FB8),
                        Color(0xFF005F80),
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),//blue part
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [

                      const SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: Image.asset(
                          "images/logo.png",
                          width: MediaQuery.of(context).size.width / 3,
                          fit: BoxFit.cover,
                        ),
                      ), //center logo
                      const SizedBox(
                        height: 70.0,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height /2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),

                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Login",
                                  style: AppWidget.headlineTextFieldStyle(),
                                ), //login text
                                const SizedBox(
                                  height: 30.0,
                                ),

                                TextFormField(
                                  controller: userEmailController,
                                  validator: (value){
                                    if(value==null|| value.isEmpty){
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    ),
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email_outlined),
                                  ),
                                ), //email
                                const SizedBox(
                                  height: 30.0,
                                ),

                                TextFormField(
                                  controller: userPasswordController,
                                  validator: (value){
                                    if(value==null|| value.isEmpty){
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    ),
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    filled: true,
                                  ),
                                ), //password
                                const SizedBox(
                                  height: 15.0,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context)=>const ForgotPassword())
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: AppWidget.lightTextFieldStyle(),
                                    ),
                                  ),
                                ),//forgot password
                                const SizedBox(
                                  height: 40.0,
                                ),

                                GestureDetector(
                                  onTap: (){
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        email= userEmailController.text;
                                        password= userPasswordController.text;
                                      });
                                    }
                                    userLogin();
                                  },
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF008FB8),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: const Center(
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontFamily: 'Poppins1',
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 30.0,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Signup()
                                )
                            );
                          },
                          child:  const Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
