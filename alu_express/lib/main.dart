import 'package:alu_express/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express/ui_screens/login_ui_screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define an async function to initialize FlutterFire
  String userId;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      User userdata = FirebaseAuth.instance.currentUser;

      print(userdata);
      if (((userdata.uid).length) > 5) {
        setState(() {
          print(userdata.uid);
          userId = userdata.uid;
//        islogged in is  set to true showing that user is logged in
          isLoggedIn = true;
        });
        print(isLoggedIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.red[900], primarySwatch: Colors.amber),
      title: 'ALU Express',
      home: isLoggedIn
          ? HomePage(userid: userId)
          : LandingPage(), // AddProductsPage()
      debugShowCheckedModeBanner: false,
    );
  }
}
