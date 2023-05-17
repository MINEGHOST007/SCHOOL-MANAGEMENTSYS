import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgot extends StatefulWidget {
  const forgot({Key? key}) : super(key: key);

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  final emailcontroller = TextEditingController();

  @override
  void dispose(){
    emailcontroller.dispose();
    super.dispose();
  }
  void passwordreset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      showsuccess();
    }
    on FirebaseAuthException catch(e){
      showerror();
    }
  }
  void showsuccess(){
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: Text(' ✅ Check your email for password reset',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
  void showerror(){
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: Text(' 🚫 Account not found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        elevation: 0,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size:50,
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text("Enter your email associated to your account",
                style: TextStyle(
                  fontFamily: 'Tinos',
                  fontSize: 20,
                ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, 0.8),
                  blurRadius: 20.0,
                  offset: Offset(0,10),
                //border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " 📬 Email",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),

                  ),
                  controller: emailcontroller,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            MaterialButton(
              onPressed: () {
                passwordreset();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color.fromRGBO(143, 148, 251, 1),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Tinos',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
