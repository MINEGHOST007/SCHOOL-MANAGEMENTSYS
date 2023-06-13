import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();

}

class _SignupState extends State<Signup> {
  final emailcontroller = TextEditingController();
  final pcontroller = TextEditingController();
  final cpcontroller = TextEditingController();
  var category = 0;
  Color _contcolor1 = const Color.fromRGBO(183, 194, 255, 1);
  Color _contcolor2 = Color.fromARGB(255, 255, 255, 255);
  void changeColor1() {
    category = 0;
    setState(() {
      _contcolor2 = const Color.fromARGB(255, 255, 255, 255);
      _contcolor1 = const Color.fromRGBO(183, 194, 255, 1);
    });

    print("CREATE ACCOUYNT");
  }

  void changeColor2() {
    category = 1;
    setState(() {
      _contcolor1 = Color.fromARGB(255, 255, 255, 255);
      _contcolor2 = const Color.fromRGBO(183, 194, 255, 1);
    });
    print("CREATE ACCOUYNT");
  }

  void createAccount() async {
    try {
      if (pcontroller.text == cpcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: pcontroller.text,
        );
        showsuccess();
      } else
        showerror2();
    } on FirebaseAuthException catch (e) {
      showerror();
    }
  }

  void showsuccess() async {
    final db = FirebaseFirestore.instance;
    if (category == 1) {
      var user = <String, dynamic>{
        "email": emailcontroller.text,
        "role": "teacher"
      };
      db.collection("users").add(user).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    } else {
      var user = <String, dynamic>{
        "email": emailcontroller.text,
        "role": "student"
      };
      db.collection("users").add(user).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    }
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Account created',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          );
        });
  }

  void showerror() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' 🚫 Account already exists',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  void showerror2() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' 🚫 passwords do not match',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  int getcat() {
    return category;
  }

  @override
  Widget build(BuildContext context) {
    print("CREATE ACCOUNT");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/light-1.png'),
                              ),
                            ),
                          ),
                          context),
                    ),
                    Positioned(
                      left: 130,
                      width: 60,
                      height: 150,
                      top: -45,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/light-2.png'),
                              ),
                            ),
                          ),
                          context),
                    ),
                    Positioned(
                      right: 40,
                      width: 60,
                      height: 150,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'),
                              ),
                            ),
                          ),
                          context),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          "Signup",
                          style: TextStyle(
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
                padding:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 25),
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
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 25.0,
                              ),
                              Expanded(
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 0.8),
                                          blurRadius: 20.0,
                                          offset: Offset(10, 10),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => {changeColor1()},
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: _contcolor1,
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Student",
                                                  style: TextStyle(
                                                    fontFamily: 'Tinos',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40.0,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => {changeColor2()},
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: _contcolor2,
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Teacher",
                                                  style: TextStyle(
                                                    fontFamily: 'Tinos',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " 📬 Email or Phone number ",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              controller: emailcontroller,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
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
                              controller: pcontroller,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " 🔒 Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              controller: cpcontroller,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: () {
                        createAccount();
                      },
                      child: Container(
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
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // const Text("Already have an account Sign in?",
                    //   style: TextStyle(
                    //     color: Color.fromRGBO(143, 148, 251, 1),
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
