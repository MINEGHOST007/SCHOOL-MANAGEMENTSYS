import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signUserout(){
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/splash');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserout, icon: const Icon(Icons.logout_rounded))],
      ),
      body: const Center(
        child: Text("LOGGED IN"),
      ),
    );
  }
}
