import 'package:edusphere/presentation/screens/auth.dart';
import 'package:edusphere/presentation/screens/forgot.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/screens/signin.dart';
import 'package:edusphere/presentation/screens/signup.dart';
import 'package:edusphere/services/notification.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) =>
            const AuthPage(), //just not necessary to login everytime check whether logged in or not local storage.....
        '/load': (context) => const Loading(), //loading
        //
        '/createaccount': (context) =>
            const Signup(), // splash screen has two choices create login
        //
        '/login': (context) =>
            const Signin(), //if not logged in after splash screen to login even adding google login
        //
        '/home': (context) =>
            const HomePage(), // side bar with logout option list of subjects a search option  and below a constant menu.
        '/fp': (context) => const forgot() // forgot password page ..
        //
        // '/tasks'  : (context)=> (),//assignments with below constant menu : teacher will have an option to add tasks here and veiw attendance of any student with name
        //                           //principal can also add task to only teachers / both teachers and student and principal can see attendance of any teacher and any student
        //
        // '/profile': (context)=> (),//attendance of yourself your name , grade , contact information... option to update...
        //
        // //'/academic calender': (context)=> (),//teacher can add tests
      },
    ));
  });
}
