import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/GoogleSignInProvider.dart';
import 'package:flutter_google_signin/Models/newUserModel.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final currentuser = FirebaseAuth.instance.currentUser;
  final _txtName = TextEditingController();
  //final _txtEmail = TextEditingController();
  final _txtNumber = TextEditingController();
  final _txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // ignore: prefer_const_constructors
            Text(
              'Complete',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ignore: prefer_const_constructors
            TextField(
              controller: _txtName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              enabled: false,
              controller: TextEditingController(text: currentuser?.email),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _txtNumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _txtPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // print(_txtName.text);
                // print(_txtEmail.text);
                // print(_txtNumber.text);
                // print(_txtPassword.text);
                GoogleSignInProvider provider = new GoogleSignInProvider();
                newUserModel usr = newUserModel(
                  uid: currentuser!.uid,
                  fullName: _txtName.text,
                  email: currentuser!.email,
                  phoneNumber: _txtNumber.text,
                );

                provider.addDataToDbNew(usr);
                print('Success');
              },
              child: const Text('Complete'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                GoogleSignInProvider provider2 = new GoogleSignInProvider();

                provider2.logout();
              },
              child: const Text('Logout'),
            )
          ]),
        ),
      ),
    );
  }
}
