import 'package:flutter/material.dart';
import 'Home.dart';
import 'dart:async';
import 'HomeSkip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


var uid;
var userEmail;

Future<void> _getUser() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  userEmail=user.email;
  print('$userEmail');
}

Future<void> check() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('uid');
  print("Success :-");
  print(uid);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  check();
  _getUser();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return MaterialApp(
        title: "Pothole",
        home: Home(),
        debugShowCheckedModeBanner: false,
      );
    }
    else {

      return MaterialApp(
        title: "Pothole",
        home: HomeSkip(),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}



