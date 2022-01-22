import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  //const LoggedIn({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGGED IN'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text('Name: ' + user!.displayName!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
