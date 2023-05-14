import 'package:flutter/material.dart';
import 'dart:math';
import 'package:edusphere/presentation/widgets/animations.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin{
  // late AnimationController _scaleController;
  // late AnimationController _scale2Controller;
  // late AnimationController _widthController;
  // late AnimationController _positionController;
  //
  // late Animation<double> _scaleAnimation;
  // late Animation<double> _scale2Animation;
  // late Animation<double> _widthAnimation;
  // late Animation<double> _positionAnimation;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _scaleController = AnimationController(vsync: this,
  //   duration: const Duration(milliseconds: 300),);
  //
  //   _scaleAnimation =
  //
  // }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(210, 218, 255, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top:-130,
                left:0,
                child: FadeAnimation(1,Container(
                  width: width,
                  height: 420,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/one.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),context),
            ),
            Positioned(
              top:-180,
              left:0,
              child: FadeAnimation(2,Container(
                width: width,
                height: 420,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/one.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),context),
            ),
            Positioned(
              top:-230,
              left:0,
              child: FadeAnimation(3,Container(
                width: width,
                height: 420,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/one.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),context),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FadeAnimation(1,
                      const Text('Welcome to',
                      style:TextStyle(
                        color: Color.fromRGBO(11, 36, 71, 0.6),
                        height: 1.4,
                        fontSize: 25,
                      ),), context),
                  const SizedBox(height:15,),
                      const Text('EduSphere',
                        style:TextStyle(
                          color: Color.fromRGBO(11, 36, 71, 1),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),),
                  const SizedBox(height:10,),
                      const Text('A School Management System',
                        style:TextStyle(
                          color: Color.fromRGBO(12, 19, 79, 0.4),
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                        ),),
                  const SizedBox(height:90,),
                  FadeAnimation(1.6,
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 180,
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,

                              ),
                              child: Container(
                                width: 160,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: const Center(
                                  child: Text("SIGN UP",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  ),
                                ),
                              ),),
                            const SizedBox(height:25,),
                            Container(
                              width: 180,
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,

                              ),
                              child: Container(
                                width: 160,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: const Center(
                                  child: Text("SIGN IN",style: TextStyle(
                                      color: Colors.white,
                                    fontSize: 17,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  ),
                                ),
                              ),),

                          ],),
                      ),
                      context),



                  const SizedBox(height: 75,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
