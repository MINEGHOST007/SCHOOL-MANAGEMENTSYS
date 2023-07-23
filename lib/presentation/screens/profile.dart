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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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

  Future<void> refresh() {
    setState(() {
      count = 0;
    });
    return Future.delayed(Duration(seconds: 3));
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
            name = await gn.getRole();
            if (role == "student") {
              cls = await gc.getRole();
              role = await getuser.getRole();
              roll = await grn.getrn();
            } else {}

            print(
                'letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
            print(role);
            print(present);
            print(cls);
            print(roll);
            print(name);

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
    print('letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    getDocId2();
    if (count == 0) {
      return const Loading();
    }
    print('letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    print(present);
    if (role == "student") {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 160,
          backgroundColor: Colors.grey[300],
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 80, left: 25),
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
                const SizedBox(
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
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          onRefresh: refresh,
          color: Color.fromRGBO(109, 116, 255, 1),
          backgroundColor: Color.fromARGB(255, 138, 156, 255),
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.all(10),
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(4, 4),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                          ),
                        ]),
                    child: Image.asset(
                      'assets/images/student.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_border_purple500),
                      const Text(
                        "You are logged in as Student",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Icon(Icons.star_border_purple500),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Editpage()),
                      ),
                    },
                    child: Container(
                      width: 240,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, 1),
                            ],
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          //border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(4, 4),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 10,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
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
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(6, 6),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name : ${name!.length<16 ? name : name!.substring(0, 16)}....",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Class : $cls",
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Roll No : $roll ",
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 500,
                        height: 150,
                        child: PieChart(
                          dataMap: dataMap,
                          colorList: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(255, 255, 255, 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Center(
                //   child: GestureDetector(
                //     onTap: () => {refresh()},
                //     child: Container(
                //       width: 240,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         gradient: const LinearGradient(
                //           colors: [
                //             Color.fromRGBO(143, 148, 251, 1),
                //             Color.fromRGBO(143, 148, 251, 0.6),
                //           ],
                //         ),
                //         borderRadius: const BorderRadius.all(Radius.circular(10)),
                //         border: Border.all(color: Colors.white, width: 2),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Text(
                //             "Refresh",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontFamily: 'Poppins',
                //               fontSize: 16,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Icon(
                //             Icons.refresh,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 160,
          backgroundColor: Colors.grey[300],
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 80, left: 25),
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
                const SizedBox(
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
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          color: Color.fromRGBO(109, 116, 255, 1),
          backgroundColor: Color.fromARGB(255, 138, 156, 255),
          height: 100,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 105,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Image.asset(
                      'assets/images/teacher.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_border_purple500),
                      const Text(
                        "You are logged in as Teacher",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Icon(Icons.star_border_purple500),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Editpage3()),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          //border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(2, 2),
                              blurRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
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
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(6, 6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name : ${name!.length<16 ? name : name!.substring(0, 16)}.....",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 500,
                        height: 150,
                        child: PieChart(
                          dataMap: dataMap,
                          colorList: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Colors.grey.shade100
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Center(
                //   child: GestureDetector(
                //     onTap: () => {refresh()},
                //     child: Container(
                //       width: 240,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         gradient: const LinearGradient(
                //           colors: [
                //             Color.fromRGBO(143, 148, 251, 1),
                //             Color.fromRGBO(143, 148, 251, 0.6),
                //           ],
                //         ),
                //         borderRadius: const BorderRadius.all(Radius.circular(10)),
                //         border: Border.all(color: Colors.white, width: 2),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Text(
                //             "Refresh",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontFamily: 'Poppins',
                //               fontSize: 16,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Icon(
                //             Icons.refresh,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class decider extends StatefulWidget {
  const decider({super.key});

  @override
  State<decider> createState() => _deciderState();
}

class _deciderState extends State<decider> {
  String role = "";
  String name = "";
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdat();
  }

  void getdat() async {
    GetUserNamee gh = GetUserNamee();
    role = (await gh.getRole())!;
    Getname gn = Getname();
    name = (await gn.getRolefirst())!;
    if (role != "" && name != "") {
      setState(() {
        role = role;
      });
    }
  }

  Future<void> refresh() async {}

  @override
  Widget build(BuildContext context) {
    if (role == "") {
      return Loading();
    } else if (role == "principal") {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 160,
          backgroundColor: Colors.grey[300],
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 80, left: 25),
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
                const SizedBox(
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
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          color: Color.fromRGBO(109, 116, 255, 1),
          backgroundColor: Color.fromARGB(255, 138, 156, 255),
          height: 100,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 105,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Image.asset(
                      'assets/images/teacher.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_border_purple500),
                      const Text(
                        "PRINCIPAL",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Icon(Icons.star_border_purple500),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Editpage3()),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          //border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(2, 2),
                              blurRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
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
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(6, 6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name : ${name.length<16 ? name : name.substring(0, 16)}.....",
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Center(
                //   child: GestureDetector(
                //     onTap: () => {refresh()},
                //     child: Container(
                //       width: 240,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         gradient: const LinearGradient(
                //           colors: [
                //             Color.fromRGBO(143, 148, 251, 1),
                //             Color.fromRGBO(143, 148, 251, 0.6),
                //           ],
                //         ),
                //         borderRadius: const BorderRadius.all(Radius.circular(10)),
                //         border: Border.all(color: Colors.white, width: 2),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Text(
                //             "Refresh",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontFamily: 'Poppins',
                //               fontSize: 16,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Icon(
                //             Icons.refresh,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Profilepage();
    }
  }
}
