import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute :'/splash',
    routes: {
      '/'       : (context)=> (),//loading

      '/splash' : (context)=> (),//just not necessary to login everytime check whether logged in or not local storage.....

      '/login'  : (context)=> (),//if not logged in after splash screen to login even adding google login

      '/home'   : (context)=> (),// side bar with logout option list of subjects a search option  and below a constant menu.

      '/tasks'  : (context)=> (),//assignments with below constant menu : teacher will have an option to add tasks here and veiw attendance of any student with name
                                //principal can also add task to only teachers / both teachers and student and principal can see attendance of any teacher and any student

      '/profile': (context)=> (),//attendance of yourself your name , grade , contact information... option to update...

      //'/tests': (context)=> (),//teacher can add tests
    },
  ));
}
