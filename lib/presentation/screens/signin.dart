import 'package:edusphere/common/utils.dart';
import 'package:edusphere/presentation/screens/auth.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:edusphere/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edusphere/main.dart';
import 'package:edusphere/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{
    Navigator.pushNamed(context, '/',arguments: { 'email': usernameController.text, 'password':passwordController.text},);
  }
  @override
  Widget build(BuildContext context) {
    print("CREATE ACCOUYNT");
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(

                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/four.png'),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    width: 60,
                    height: 200,
                    top: -45,
                    child: FadeAnimation(1,Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/light-1.png'),
                        ),
                      ),
                    ), context),
                  ),
                  Positioned(
                    left: 130,
                    width: 60,
                    height: 150,
                    top: -45,
                    child: FadeAnimation(1.3,Container(

                      decoration: const BoxDecoration(

                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/light-2.png'),
                        ),
                      ),
                    ), context),
                  ),
                  Positioned(
                    right: 40,
                    width: 60,
                    height: 150,
                    child: FadeAnimation(1.5,Container(

                      decoration: const BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('assets/images/clock.png'),
                        ),
                      ),
                    ), context),
                  ),
                  const Positioned(
                    child: Center(
                      child: Text("Login",
                        style:TextStyle(
                          // fontFamily: 'Tinos',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontFamily: 'Tinos',
                  ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, 0.8),
                            blurRadius: 20.0,
                            offset: Offset(0,10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD),)),
                            ),
                            child: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " 📬 Email or Phone number ",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD),)),
                            ),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " 🔒 Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),

                              ),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height:35),
                  GestureDetector(
                    onTap: (){
                      print("tried to sign in");
                      signUserIn();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, 0.6),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text("Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tinos',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Text("Forgot Password?",
                    style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height:15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],

                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text('Or continue with',
                          style: TextStyle(
                          ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],

                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/images/google.png', onTap: ()=> Authservice().signInWithGoogle(context),),
                      //SizedBox(width:25),
                      //SquareTile(imagePath: 'assets/images/google.png'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Not a member?'),
                      SizedBox(width: 4,),
                      Text("Register now",
                      style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}