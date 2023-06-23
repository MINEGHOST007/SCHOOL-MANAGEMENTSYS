// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Profilepage extends StatefulWidget {
//   const Profilepage({super.key});

//   @override
//   State<Profilepage> createState() => _ProfilepageState();
// }

// class _ProfilepageState extends State<Profilepage> {
//   String role = "letsgetoutofhere";
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   User? user = FirebaseAuth.instance.currentUser;

//   void fetchdata() async {
//     if (user != null) {
//       String uid = user!.uid;
//       DocumentSnapshot snapshot = firestore.collection('users').doc(uid).get() as DocumentSnapshot<Object?>;
//       print('object');
//       print(snapshot.data());

//       if (snapshot.exists) {
//       } else {}
//     }
//     //DocumentSnapshot snapshot = await firestore.collection('users').doc(user.).get();
//     //print(snapshot);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (role == "teacher") {
//       return const Scaffold(
//         body: Center(
//           child: Text("You are logged in as Teacher"),
//         ),
//       );
//     } else {
//       print("letsssssssssssssssssssssssssssssssssssssssssssss");
//       print(user);
//       fetchdata();
//       return const Scaffold(
//         body: Center(
//           child: Text("You are logged in as Student"),
//         ),
//       );
//     }
//   }
// }

import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/Editprofile.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:pie_chart/pie_chart.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  List<String> docIDs = [];

  String? role = "letsgetoutofhere";
  double? present = 0.0;
  Getclass gc = Getclass();
  Getname gn = Getname();
  String? cls = "";
  String? name = "";
  int? roll = 0;

  Getrollno grn = Getrollno();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  void refresh() {
    setState(() {
      count = 0;
    });
  }

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach((element) async {
            print(element.reference.id);
            docIDs.add(element.reference.id);
            // GetUserNameee getuser =
            //     GetUserNameee(documentId: element.reference.id);
            // role = await getuser.getRole();
          }),
        );
  }

  Map<String, double> dataMap = {
    'Present': 75,
    'Absent': 100 - 75,
  };

  int count = 0;
  Future getDocId2() async {
    String? roleee;
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach((element) async {
            print(element.reference.id);
            //docIDs.add(element.reference.id);
            // GetUserNamee getuser =
            //     GetUserNamee(documentId: element.reference.id);
            GetUserNamee getuser = GetUserNamee();
            role = await getuser.getRole();
            Getattendance ga = Getattendance();
            present = await ga.getRole();
            cls = await gc.getRole();
            name = await gn.getRole();
            role = await getuser.getRole();
            roll = await grn.getrn();

            print(
                'letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
            print(role);
            print(present);
            print(cls);
            print(roll);

            if (role != "letsgetoutofhere" && count == 0) {
              setState(() {
                role = role;
                dataMap = {
                  'Present': present! / 1,
                  'Absent': 100 - present! / 1,
                };
                count = 1;
              });
            }
          }),
        );
  }

  @override
  void initState() {
    super.initState();
    //getDocId2();
  }

  // void mostsensiblemethod() async {
  //   myprofiledoc = await ga.getRole();
  //   if (myprofiledoc != null) {
  //     setState(() {
  //       print("outtttttttttttttttttttttttttt");
  //       dataMap =
  //       role = myprofiledoc?['role'];
  //       count = 1;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // String? email = user!.email;
    // //role = getRoleStream(email, docIDs) as String;
    // role = Streamget(email, docIDs);
    getDocId2();
    if (count == 0) {
      return Loading();
    }
    print('letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    print(present);
    if (role == "student") {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 160,
          backgroundColor: Color.fromARGB(176, 196, 195, 195),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 80, left: 25),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(104, 112, 255, 1),
                  Color.fromRGBO(114, 120, 243, 0.6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.5,
                    color: Color.fromARGB(164, 255, 255, 255),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  user!.email as String,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 25.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(176, 196, 195, 195),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255), width: 3),
                  ),
                  child: Image.asset(
                    'assets/images/student.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border_purple500),
                    Text(
                      "You are logged in as Student",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Icon(Icons.star_border_purple500),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Editpage()),
                    ),
                  },
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
                          "Edit Profile",
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
              Container(
                width: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name : $name",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Class : $cls",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Roll No : $roll ",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 500,
                      height: 150,
                      child: PieChart(dataMap: dataMap),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => {refresh()},
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
                          "Refresh",
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
                          Icons.refresh,
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
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 160,
          backgroundColor: Color.fromARGB(176, 196, 195, 195),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 80, left: 25),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(104, 112, 255, 1),
                  Color.fromRGBO(114, 120, 243, 0.6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.5,
                    color: Color.fromARGB(164, 255, 255, 255),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  user!.email as String,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 25.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(176, 196, 195, 195),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text('You are logged in as Teacher'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, value) {
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GetUserName(
                              documentId: docIDs[index],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}
