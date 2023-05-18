import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> checker1() async {
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = arguments['email'];
    final String password = arguments['password'];
    //final OAuthCredential credential = arguments['credential'];
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      // else if(credential != null){
      //   await FirebaseAuth.instance.signInWithCredential(credential);
      // }
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      //Navigator.popAndPushNamed(context,'/home' );
    } on FirebaseAuthException catch (e) {
      Navigator.popAndPushNamed(context, '/login');
      if(e.code=='user-not-found'){
        wrongemail();
        print('wrong email');
      }

      if(e.code=='wrong-password')
        wrongpassword();

    }
  }

  void wrongemail() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: Text('🚫 Incorrect Email',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          ),
        ),
      );
    });
  }

  void wrongpassword() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: Text('🚫 Incorrect password',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checker1();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: SpinKitWaveSpinner(
            color: Colors.indigoAccent,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
