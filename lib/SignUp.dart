import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/CompleteProfile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'GoogleSignInProvider.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GoogleSignInProvider auth = GoogleSignInProvider();
  bool isLoggedinClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Google Sign Up'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              minimumSize: Size(double.infinity, 50),
            ),
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text('Continue With Google'),
            onPressed: login,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              minimumSize: Size(double.infinity, 50),
            ),
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text('Log Out'),
            onPressed: () {
              auth.logout();
            },
          ),
        ],
      ),
    );
  }

  void login() async {
    setState(() {
      isLoggedinClick = true;
    });
    User? user = await auth.signIn();
    if (user != null && await auth.authenticateUser(user) == false) {
      print('Signed UP');
    } else if (user != null && await auth.authenticateUser(user) == true) {
      // print(user.uid);
      // print("res + ${auth.authenticateUser(user)}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CompleteProfile()),
      );
    } else {
      setState(() {
        isLoggedinClick = false;
        print("ERROR");
        print("Already a user");
      });
    }
  }

  void authenticationuser(User user) {
    auth.authenticateUser(user).then((newUser) {
      if (newUser) {
        auth.addDataToDb(user).then((value) {
          print("Success");
        });
      } else
        print("failure");
    });
  }
}
