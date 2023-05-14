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
    final credential = arguments['credential'];
    print(credential);
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      Navigator.popAndPushNamed(context, '/home');
      // Handle the authentication success
      // You can navigate to the desired screen or perform any other actions here
    } on FirebaseAuthException catch (e) {
      if(e.code=='user-not-found')
        print("email not found");
      if(e.code=='wrong-password')
        print("wrong password");
      Navigator.popAndPushNamed(context, '/login');
      // Handle the authentication failure
      // You can show an error message or perform any other error handling here
    }
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
