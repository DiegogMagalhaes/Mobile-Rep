import 'package:firebase_project/home.dart';
import 'package:firebase_project/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xff9c27b0),
    hintColor: Color(0xff7b1fa2)
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: '', //sua API Key
        appId: '', //seu projeto ID
        messagingSenderId: '',
        projectId: '', //seu projeto ID
        storageBucket: '', //seu storageBucket
      )
  );

  runApp(MaterialApp(
    title: "Online Shop",
    home: Home(),
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}