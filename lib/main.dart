//import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/CompleteProfile.dart';
import 'package:flutter_google_signin/GoogleSignInProvider.dart';
import 'package:flutter_google_signin/SignUp.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: Scaffold(
          body: SignUp(),
        ),
      ),
    );
  }
}
