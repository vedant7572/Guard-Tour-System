import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gts/pages/bottomnav.dart';
import 'package:gts/pages/login.dart';
import 'package:gts/pages/profile.dart';
import 'package:gts/pages/signup.dart';
import 'package:gts/service/auth.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()
    );
  }
}
