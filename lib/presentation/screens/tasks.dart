import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/common/utils.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class tasks extends StatefulWidget {
  const tasks({super.key});

  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  List<String> dub = [];
  List<String> topic = [];
  List<DateTime?> x = [];
  List<DateTime?> y = [];
  List<String?> urr = [];
  int i = 0;
  int counter = 1;
  int len = 0;
  String? role;
  Future<void> getdata() async {
    GetUserNamee gu = GetUserNamee();
    role = await gu.getRole();
    if (role == "student") {
      GetAss ga = GetAss();
      List<DocumentSnapshot?>? doc = await ga.getassignment();
      if (doc![0] != null) {
        setState(() {
          len = doc.length;
          for (i = 0; i < doc.length; i++) {
            print("ccccccccccccccccccccccc");
            dub.add(doc[i]!['Subject']);
            topic.add(doc[i]!['Topic']);
            x.add((doc[i]!['assign'] as Timestamp).toDate());
            y.add((doc[i]!['Deadline'] as Timestamp).toDate());
            urr.add(doc[i]!['url']);
            counter = 1;
          }
        });
      }
    } else if (role == "teacher") {
      GetAss ga = GetAss();
      List<DocumentSnapshot?>? doc = await ga.getassignment2();
      if (doc![0] != null) {
        setState(() {
          len = doc.length;
          for (i = 0; i < doc.length; i++) {
            print("ccccccccccccccccccccccc");
            dub.add(doc[i]!['Subject']);
            topic.add(doc[i]!['Topic']);
            x.add((doc[i]!['assign'] as Timestamp).toDate());
            y.add((doc[i]!['Deadline'] as Timestamp).toDate());
            urr.add(doc[i]!['url']);
            counter = 1;
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (dub.isEmpty || topic.isEmpty || x.isEmpty || y.isEmpty)
      return Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: SpinKitWaveSpinner(
                  color: Colors.indigoAccent,
                  size: 50.0,
                ),
              ),
            ),
            Text(
              "Looks like you have not assigned any assignments yet",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    else {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          color: Color.fromRGBO(109, 116, 255, 1),
          backgroundColor: Color.fromARGB(255, 138, 156, 255),
          height: 100,
          onRefresh: getdata,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                // GestureDetector(
                //   onTap: () {
                //     getdata();
                //   },
                //   child: Container(
                //     margin: EdgeInsets.only(
                //         left: 110, right: 110, top: 15, bottom: 15),
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(25)),
                //       color: Color.fromRGBO(93, 101, 255,1),
                //       // border: Border.all(
                //       //     color: Colors.white,
                //       //     width: 3,
                //       //     style: BorderStyle.solid),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.grey.shade500,
                //             offset: Offset(2, 2),
                //             blurRadius: 1,

                //           ),
                //           BoxShadow(
                //             color: Colors.white,
                //             offset: Offset(-2, -2),
                //             blurRadius: 1,
                //           ),
                //       ]
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.refresh,
                //           color: Colors.white,
                //           size: 20,
                //         ),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Center(
                //           child: Text(
                //             "Refresh",
                //             style: TextStyle(color: Colors.white, fontSize: 18),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                for (int i = 0; i < len; i++)
                  FadeAnimation2(
                      1.6,
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 25, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[300],
                          // border: Border.all(
                          //     color: Color.fromARGB(255, 0, 0, 0),
                          //     width: 3,
                          //     style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/xyz.jpg',
                            ),
                            fit: BoxFit.fitWidth,
                            scale: 0.5,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        child: Column(
                          children: [
                            listAss(
                              Subject: "${dub[i]}",
                              topic: "${topic[i]}",
                              x: x[i],
                              y: y[i],
                              urr: urr[i],
                              role: role,
                            ),
                          ],
                        ),
                      ),
                      context),
                SizedBox(
                  height: 80,
                ),
                // Container(
                //   margin: EdgeInsets.all(10),
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     color: Colors.white,
                //     border: Border.all(color: Color.fromARGB(255, 0, 0, 0),width: 3,style: BorderStyle.solid),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text("Subject : ",
                //           style: TextStyle(
                //             fontFamily: 'Poppins',
                //           ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 8,),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("by : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),),
                //           const SizedBox(width: 10,),
                //           Text("Deadline : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Description : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //         Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Attachments : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
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

class notices extends StatefulWidget {
  const notices({super.key});

  @override
  State<notices> createState() => _noticesState();
}

class _noticesState extends State<notices> {
  List<String> dub = [];
  List<String> topic = [];
  List<DateTime?> x = [];
  List<DateTime?> y = [];
  List<String?> urr = [];
  int i = 0;
  int counter = 1;
  int len = 0;
  String? role;
  Future<void> getdata() async {
    GetUserNamee gu = GetUserNamee();
    role = await gu.getRole();
    if (role == "student") {
      GetAss ga = GetAss();
      List<DocumentSnapshot?>? doc = await ga.getassignment();
      if (doc![0] != null) {
        setState(() {
          len = doc.length;
          for (i = 0; i < doc.length; i++) {
            print("ccccccccccccccccccccccc");
            dub.add(doc[i]!['Subject']);
            topic.add(doc[i]!['Topic']);
            x.add((doc[i]!['assign'] as Timestamp).toDate());
            y.add((doc[i]!['Deadline'] as Timestamp).toDate());
            urr.add(doc[i]!['url']);
            counter = 1;
          }
        });
      }
    } else if (role == "teacher") {
      GetAss ga = GetAss();
      List<DocumentSnapshot?>? doc = await ga.getassignment2();
      if (doc![0] != null) {
        setState(() {
          len = doc.length;
          for (i = 0; i < doc.length; i++) {
            print("ccccccccccccccccccccccc");
            dub.add(doc[i]!['Subject']);
            topic.add(doc[i]!['Topic']);
            x.add((doc[i]!['assign'] as Timestamp).toDate());
            y.add((doc[i]!['Deadline'] as Timestamp).toDate());
            urr.add(doc[i]!['url']);
            counter = 1;
          }
        });
      }
    }
    else if(role == "principal"){
      GetAss ga = GetAss();
      List<DocumentSnapshot?>? doc = await ga.getassignment2();
      if (doc![0] != null) {
        setState(() {
          len = doc.length;
          for (i = 0; i < doc.length; i++) {
            print("ccccccccccccccccccccccc");
            dub.add(doc[i]!['Subject']);
            topic.add(doc[i]!['Topic']);
            x.add((doc[i]!['assign'] as Timestamp).toDate());
            counter = 1;
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (dub.isEmpty || topic.isEmpty || x.isEmpty)
      return Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: SpinKitWaveSpinner(
                  color: Colors.indigoAccent,
                  size: 50.0,
                ),
              ),
            ),
            Text(
              "Looks like you have not assigned any notices yet",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    else {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          color: Color.fromRGBO(109, 116, 255, 1),
          backgroundColor: Color.fromARGB(255, 138, 156, 255),
          height: 100,
          onRefresh: getdata,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                // GestureDetector(
                //   onTap: () {
                //     getdata();
                //   },
                //   child: Container(
                //     margin: EdgeInsets.only(
                //         left: 110, right: 110, top: 15, bottom: 15),
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(25)),
                //       color: Color.fromRGBO(93, 101, 255,1),
                //       // border: Border.all(
                //       //     color: Colors.white,
                //       //     width: 3,
                //       //     style: BorderStyle.solid),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.grey.shade500,
                //             offset: Offset(2, 2),
                //             blurRadius: 1,

                //           ),
                //           BoxShadow(
                //             color: Colors.white,
                //             offset: Offset(-2, -2),
                //             blurRadius: 1,
                //           ),
                //       ]
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.refresh,
                //           color: Colors.white,
                //           size: 20,
                //         ),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Center(
                //           child: Text(
                //             "Refresh",
                //             style: TextStyle(color: Colors.white, fontSize: 18),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                for (int i = 0; i < len; i++)
                  FadeAnimation2(
                      1.6,
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 25, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[300],
                          // border: Border.all(
                          //     color: Color.fromARGB(255, 0, 0, 0),
                          //     width: 3,
                          //     style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/xyz.jpg',
                            ),
                            fit: BoxFit.fitWidth,
                            scale: 0.5,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        child: Column(
                          children: [
                            listAss2(
                              Subject: "${dub[i]}",
                              topic: "${topic[i]}",
                              x: x[i],
                              role: role,
                            ),
                          ],
                        ),
                      ),
                      context),
                SizedBox(
                  height: 80,
                ),
                // Container(
                //   margin: EdgeInsets.all(10),
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     color: Colors.white,
                //     border: Border.all(color: Color.fromARGB(255, 0, 0, 0),width: 3,style: BorderStyle.solid),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text("Subject : ",
                //           style: TextStyle(
                //             fontFamily: 'Poppins',
                //           ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 8,),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("by : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),),
                //           const SizedBox(width: 10,),
                //           Text("Deadline : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Description : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //         Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Attachments : ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
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
