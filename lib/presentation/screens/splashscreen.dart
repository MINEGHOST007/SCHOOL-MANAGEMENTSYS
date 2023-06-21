import 'dart:ui';

import 'package:flutter/material.dart';
// import 'dart:math';
import 'package:edusphere/presentation/widgets/animations.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: const Color.fromRGBO(210, 218, 255, 1),
        backgroundColor: const Color.fromRGBO(156, 126, 215, 0.25),
        //backgroundColor:const Color.fromRGBO(215, 169, 255, 0.25) ,
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: -130,
                left: 0,
                child: FadeAnimation(
                    1,
                    Container(
                      width: width,
                      height: 420,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    context),
              ),
              Positioned(
                top: -180,
                left: 0,
                child: FadeAnimation(
                    2,
                    Container(
                      width: width,
                      height: 420,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    context),
              ),
              Positioned(
                top: -230,
                left: 0,
                child: FadeAnimation(
                    3,
                    Container(
                      width: width,
                      height: 420,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    context),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FadeAnimation(
                        1,
                        const Text(
                          'Welcome to',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(11, 36, 71, 0.6),
                            height: 1.4,
                            fontSize: 25,
                          ),
                        ),
                        context),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: const [
                        Text(
                          'EduSphere',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(11, 36, 71, 1),
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/three.png'),
                          radius: 45,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'A School Management App',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: Color.fromRGBO(12, 19, 79, 0.4),
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 72,
                    ),
                    FadeAnimation(
                        1.6,
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("SIgnup");
                                  Navigator.pushNamed(
                                      context, '/createaccount');
                                },
                                child: Container(
                                  width: 210,
                                  height: 60,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    width: 160,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        //shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(113, 73, 198, 0.8)),
                                    child: const Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 17,
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("SIGN UP");
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Container(
                                  width: 210,
                                  height: 60,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    width: 180,
                                    height: 67.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      //shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      color: Color.fromRGBO(113, 73, 198, 0.8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "SIGN IN",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        context),
                    const SizedBox(
                      height: 72,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
