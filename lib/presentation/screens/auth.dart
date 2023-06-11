import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/screens/signin.dart';
import 'package:edusphere/presentation/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edusphere/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          print(snapshot);
          if(snapshot.hasData){
            return HomePage();
          }
          else
            {
              print(snapshot);
              return Splash();
            }
        },
      ),
    );
  }
}
