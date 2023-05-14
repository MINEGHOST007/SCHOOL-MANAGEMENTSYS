import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:flutter/material.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                      child: Text("Signup",
                          style:TextStyle(
                            fontFamily: 'Tinos',
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
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
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
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: TextField(
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
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: TextField(
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
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " 🔒 Confirm Password",
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


                  const SizedBox(height:30),
                  Container(
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
                      child: Text("Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70,),
                  // const Text("Already have an account Sign in?",
                  //   style: TextStyle(
                  //     color: Color.fromRGBO(143, 148, 251, 1),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Already have an account?'),
                      SizedBox(width: 4,),
                      Text("Sign in",
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
