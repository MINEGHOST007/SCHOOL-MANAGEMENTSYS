import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  String? namecontroller;

  int? cls;

  void Updateprofile() {
    print(cls);
    print(namecontroller);
    if (cls != null && namecontroller != "") {
      Updatename(cls: cls, name: namecontroller).getRole();
      showsuccess();
    } else
      showerror();
  }

  void showerror() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' 🚫 empty feilds',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  void Deleteprofile() async {
    User? user = FirebaseAuth.instance.currentUser;
    Getstudentdocs gb = Getstudentdocs();
    List<DocumentSnapshot> x = await gb.getteacher();
    for (int i = 0; i < x.length; i++) {
      if (x[i]['email'] == user!.email) {
        String docId = x[i].id;
        DocumentReference documentRef =
            FirebaseFirestore.instance.collection("users").doc("$docId");
        try {
          // Deleting the document
          await documentRef.delete();
          print("Document deleted successfully");
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          print("Error deleting document: $e");
        }
      }
    }
  }

  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Changes Saved Refresh ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
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
        title: Text(
          "Edit profile details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromRGBO(109, 116, 255, 1),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeAnimation2(
                1.6,
                Container(
                  margin:
                      EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 60),
                  width: 500,
                  padding: EdgeInsets.only(
                      top: 100, left: 50, right: 50, bottom: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //     color: Color.fromARGB(255, 86, 103, 255),
                      //     style: BorderStyle.solid)
                      color: Colors.grey[300],
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-6, -6),
                          color: Colors.white,
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          offset: const Offset(4, 4),
                          color: Colors.grey.shade500,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        "Edit name",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(),
                        child: TextField(
                          onChanged: (value) => namecontroller = value,
                          decoration: InputDecoration(
                            hintText: " Full name ",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 27.5,
                      ),
                      Text(
                        "Edit class",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Center(
                        child: DropdownButton<int>(
                          value: cls,
                          hint: Text('Select your class'),
                          items: List.generate(10, (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text((index + 1).toString()),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              cls = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 17.5,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () =>
                              {print("xxxxxxxxxxxxxxxx"), Updateprofile()},
                          child: Container(
                            width: 240,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, 0.6),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  const BoxShadow(
                                    offset: Offset(-6, -6),
                                    color: Colors.white,
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    offset: const Offset(4, 4),
                                    color: Colors.grey.shade500,
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                context),
            FadeAnimation2(
                1.6,
                Center(
                  child: GestureDetector(
                    onTap: () => {print("xxxxxxxxxxxxxxxx"), Deleteprofile()},
                    child: Container(
                      width: 240,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            const BoxShadow(
                              offset: Offset(-6, -6),
                              color: Colors.white,
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              offset: const Offset(4, 4),
                              color: Colors.grey.shade500,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Delete Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 0, 0),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                context),
          ],
        ),
      ),
    );
  }
}

class Editpage2 extends StatefulWidget {
  String email;
  Editpage2({super.key, required this.email});

  @override
  State<Editpage2> createState() => _Editpage2State();
}

class _Editpage2State extends State<Editpage2> {
  String? namecontroller;

  int? cls;
  int present = 100;
  int absent = 0;

  void Updateprofile() {
    Updatename2(cls: present, name: absent).getRole(widget.email);
    showsuccess();
  }

  void Deleteprofile() {}
  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Changes Saved Refresh ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
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
        title: Text(
          "Edit Attendance details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromRGBO(109, 116, 255, 1),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 60),
              width: 500,
              padding:
                  EdgeInsets.only(top: 60, left: 50, right: 50, bottom: 30),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //     color: Color.fromARGB(255, 86, 103, 255),
                  //     style: BorderStyle.solid),
                  boxShadow: [
                    const BoxShadow(
                      offset: Offset(-6, -6),
                      color: Colors.white,
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      offset: const Offset(4, 4),
                      color: Colors.grey.shade500,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  const SizedBox(
                    height: 7.5,
                  ),
                  Text(
                    "${widget.email}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Text(
                    "Edit present",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 17.5,
                  ),
                  TextField(
                    onChanged: (value) => present = int.parse(value),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(
                    height: 17.5,
                  ),
                  Text(
                    "Edit absent",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextField(
                    onChanged: (value) => absent = int.parse(value),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(
                    height: 17.5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => {print("xxxxxxxxxxxxxxxx"), Updateprofile()},
                      child: Container(
                        width: 240,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, 0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              const BoxShadow(
                                offset: Offset(-6, -6),
                                color: Colors.white,
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                offset: const Offset(4, 4),
                                color: Colors.grey.shade500,
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Changes",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {print("xxxxxxxxxxxxxxxx"), Deleteprofile()},
                child: Container(
                  width: 240,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, 0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      //border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-6, -6),
                          color: Colors.white,
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          offset: const Offset(4, 4),
                          color: Colors.grey.shade500,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delete Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 255, 0, 0),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 47.5,
            ),
          ],
        ),
      ),
    );
  }
}

class Editpage3 extends StatefulWidget {
  const Editpage3({super.key});

  @override
  State<Editpage3> createState() => _Editpage3State();
}

class _Editpage3State extends State<Editpage3> {
  String? namecontroller;
  String? namecontroller2;

  void Updateprofile() {
    print(namecontroller);
    if (namecontroller != "" && namecontroller2 != "") {
      Updatename3(fname: namecontroller, sname: namecontroller2).getRole();
      showsuccess();
    } else
      showerror();
  }

  void showerror() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' 🚫 empty details',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  void Deleteprofile() async {
    User? user = FirebaseAuth.instance.currentUser;
    Getteacherdocs gb = Getteacherdocs();
    List<DocumentSnapshot> x = await gb.getteacher();
    for (int i = 0; i < x.length; i++) {
      if (x[i]['email'] == user!.email) {
        String docId = x[i].id;
        DocumentReference documentRef =
            FirebaseFirestore.instance.collection("users").doc("$docId");
        try {
          // Deleting the document
          await documentRef.delete();
          print("Document deleted successfully");
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          print("Error deleting document: $e");
        }
      }
    }
  }

  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Changes Saved Refresh ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
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
        title: Text(
          "Edit profile details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromRGBO(109, 116, 255, 1),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 60),
              width: 500,
              padding:
                  EdgeInsets.only(top: 100, left: 50, right: 50, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  // border: Border.all(
                  //     color: Color.fromARGB(255, 86, 103, 255),
                  //     style: BorderStyle.solid)
                  boxShadow: [
                    const BoxShadow(
                      offset: Offset(-6, -6),
                      color: Colors.white,
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      offset: const Offset(4, 4),
                      color: Colors.grey.shade500,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  Text(
                    "Edit first name",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(),
                    child: TextField(
                      onChanged: (value) => namecontroller = value,
                      decoration: InputDecoration(
                        hintText: " Full name ",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Text(
                    "Edit second name",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(),
                    child: TextField(
                      onChanged: (value) => namecontroller2 = value,
                      decoration: InputDecoration(
                        hintText: " Full name ",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => {print("xxxxxxxxxxxxxxxx"), Updateprofile()},
                      child: Container(
                        width: 240,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, 0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              const BoxShadow(
                                offset: Offset(-6, -6),
                                color: Colors.white,
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                offset: const Offset(4, 4),
                                color: Colors.grey.shade500,
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Changes",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => {print("xxxxxxxxxxxxxxxx"), Deleteprofile()},
                child: Container(
                  width: 240,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, 0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      //border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-6, -6),
                          color: Colors.white,
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          offset: const Offset(4, 4),
                          color: Colors.grey.shade500,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delete Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 255, 0, 0),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
