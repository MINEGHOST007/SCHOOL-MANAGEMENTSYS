// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Authservice{
//
//   signInWIthGoogle() async{
//     final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication gAuth = await guser!.authentication;
//
//     final crendential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     Navigator.popAndPushNamed(context, '/load',arguments: {
//
//     });
//
//     // return await FirebaseAuth.instance.signInWithCredential(crendential);
//   }
// }

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Authservice {
//   Future<void> signInWithGoogle(BuildContext context) async {
//     final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication gAuth = await guser!.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     await FirebaseAuth.instance.signInWithCredential(credential);
//
//     Navigator.popAndPushNamed(context, '/home');
// //
//     // await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }

import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../presentation/screens/signup.dart';

class Authservice {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  int category;
  Authservice({required this.category});
  Future<void> signInWithGoogle(BuildContext context) async {
    // Sign out the user to clear the cached sign-in information
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print("new google login");
    }
    //await _googleSignIn.signOut();

    final GoogleSignInAccount? guser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication gAuth = await guser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    Navigator.pushNamed(context, '/load');
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user!.email;
    print(userCredential.additionalUserInfo?.isNewUser ?? false);
    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      if (category == 1) {
        var user = <String, dynamic>{"email": email, "role": "teacher"};
        db.collection("users").add(user).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
      } else {
        var user = <String, dynamic>{"email": email, "role": "student"};
        db.collection("users").add(user).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
      }
    } else {
      // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      // print( await GetUserNamee(documentId: 'xyz').getRole());
      // if (await GetUserNamee(documentId: 'xyz').getRole() == 'teacher' &&
      //      category == 1) {
      //    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      //    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      // } else if(await GetUserNamee(documentId: 'xyz').getRole() == 'student' &&
      //      category == 0) {
      //    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      //    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      // }
      // else{
      //   await _googleSignIn.signOut();
      //   Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
      // }
    }

    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    //Navigator.pushNamed(context, '/home');
    //Navigator.pushNamed(context, '/',arguments: {'email':null,'password':null, 'credential' : credential});
  }
}
