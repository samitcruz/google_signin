import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_signin/Models/UserModel.dart';
import 'package:flutter_google_signin/Models/newUserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInProvider extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection("Users");

  User getCurrentUser() {
    User currentUser = _auth.currentUser!;
    return currentUser;
  }

  Future<UserModel> getUserDetails() async {
    User currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();
    return UserModel.fromMap(documentSnapshot.data as Map<String, dynamic>);
  }

  Future<UserModel> getUserDetailsbyId(id) async {
    User currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
    print(documentSnapshot.data());
    return UserModel.fromMap(documentSnapshot.data as Map<String, dynamic>);
  }

  Future<User?> signIn() async {
    try {
      GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: _signInAuthentication.accessToken,
          idToken: _signInAuthentication.idToken);

      User user = (await _auth.signInWithCredential(credential)).user!;
      return user;
    } catch (e) {
      print("Error: Auth Sign in");
      print(e);

      return null;
    }
    notifyListeners();
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result =
        await _userCollection.where("email", isEqualTo: user.email).get();
    final List<DocumentSnapshot> docs = result.docs;

    return docs.isEmpty ? true : false;
    notifyListeners();
  }

  Future<void> addDataToDb(User currentUser) async {
    UserModel user = UserModel(
      uid: currentUser.uid,
      email: currentUser.email,
      fullName: currentUser.displayName,
    );

    firestore
        .collection("Users")
        .doc(currentUser.uid)
        .set(user.toMap(user) as Map<String, dynamic>);
  }

  Future<void> addDataToDbNew(newUserModel currentUser) async {
    newUserModel user = newUserModel(
      uid: currentUser.uid,
      email: currentUser.email,
      fullName: currentUser.fullName,
      phoneNumber: currentUser.phoneNumber,
    );

    firestore
        .collection("Users")
        .doc(currentUser.uid)
        .set(user.toMap(user) as Map<String, dynamic>);
  }

  Future logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}




// GoogleSignInAccount? _user;

//   GoogleSignInAccount get user => _user!;

//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;

//     final googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);

//     notifyListeners();
//   }

//   Future logout() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//   }