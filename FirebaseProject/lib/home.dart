import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          onPressed: () {
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
