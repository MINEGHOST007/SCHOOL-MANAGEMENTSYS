import 'package:edusphere/presentation/screens/auth.dart';
import 'package:edusphere/presentation/screens/forgot.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/screens/signin.dart';
import 'package:edusphere/presentation/screens/signup.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edusphere/presentation/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute :'/splash',
    routes: {
      '/'       : (context)=> Loading(),//loading

      '/splash' : (context)=> AuthPage(),//just not necessary to login everytime check whether logged in or not local storage.....
      //
           '/createaccount': (context)=>Signup(),// splash screen has two choices create login
      //
       '/login'  : (context)=> Signin(),//if not logged in after splash screen to login even adding google login
      //
      '/home'   : (context)=> HomePage(),// side bar with logout option list of subjects a search option  and below a constant menu.
      '/fp'     : (context)=> forgot() // forgot password page ..
      //
      // '/tasks'  : (context)=> (),//assignments with below constant menu : teacher will have an option to add tasks here and veiw attendance of any student with name
      //                           //principal can also add task to only teachers / both teachers and student and principal can see attendance of any teacher and any student
      //
      // '/profile': (context)=> (),//attendance of yourself your name , grade , contact information... option to update...
      //
      // //'/tests': (context)=> (),//teacher can add tests
    },
  ));
}
