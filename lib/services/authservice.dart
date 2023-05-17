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


import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservice {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    // Sign out the user to clear the cached sign-in information
    try{
      await _googleSignIn.signOut();
    }
    catch(e){
      print("new google login");
    }
    //await _googleSignIn.signOut();

    final GoogleSignInAccount? guser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication gAuth = await guser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    Navigator.pushNamed(context, '/');
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushNamed(context, '/home');
    //Navigator.pushNamed(context, '/',arguments: {'email':null,'password':null, 'credential' : credential});

  }
}
