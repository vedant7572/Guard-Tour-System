import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gts/pages/bottomnav.dart';
import 'package:gts/pages/login.dart';

class AuthMethods{
  final FirebaseAuth auth=FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in directly go to landing page
          if (snapshot.hasData) {
            return BottomNavbar();
          }
          // user is NOT logged in go to login page
          else {
            return Login();
          }
        },
      ),
    );
  }
}