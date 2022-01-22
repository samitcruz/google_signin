import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/CompleteProfile.dart';
import 'package:flutter_google_signin/LoggedIn.dart';
import 'package:flutter_google_signin/SignUp.dart';
import 'package:flutter_google_signin/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return CompleteProfile();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'WRONG',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return SignUp();
            }
          },
        ),
      );
}
