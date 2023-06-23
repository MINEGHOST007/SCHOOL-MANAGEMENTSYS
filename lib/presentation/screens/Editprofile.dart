import 'package:edusphere/data/providers.dart';
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
    Updatename(cls: cls, name: namecontroller).getRole();
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
          "Edit profile details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromARGB(255, 64, 93, 255),
      ),
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
                  border: Border.all(
                      color: Color.fromARGB(255, 86, 103, 255),
                      style: BorderStyle.solid)),
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
                          border: Border.all(color: Colors.white, width: 2),
                        ),
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
                    border: Border.all(color: Colors.white, width: 2),
                  ),
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

  void Deleteprofile() {

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
        backgroundColor: Color.fromARGB(255, 64, 93, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 60),
              width: 500,
              padding:
                  EdgeInsets.only(top: 60, left: 50, right: 50, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color.fromARGB(255, 86, 103, 255),
                      style: BorderStyle.solid)),
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
                          border: Border.all(color: Colors.white, width: 2),
                        ),
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
                    border: Border.all(color: Colors.white, width: 2),
                  ),
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
