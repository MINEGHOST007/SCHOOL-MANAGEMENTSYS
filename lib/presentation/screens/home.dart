// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   void signUserout() {
//     FirebaseAuth.instance.signOut();
//     Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     //homescreen(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(226, 119, 56, 255),
//         actions: [IconButton(onPressed: signUserout, icon: const Icon(Icons.logout_rounded))],
//       ),
//       // body: const Center(
//       //   child: Text("LOGGED IN"),
//       // ),
//       backgroundColor: const Color(0xFFD3D3D3),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0,
//             bottom: 0),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
//                child: BottomNavigationBar(
//                 elevation: 25,
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 selectedItemColor: const Color.fromRGBO(143, 148, 251, 0.6),
//                 unselectedItemColor: const Color(0xFF526480),
//                 iconSize: 27,
//                 // items: const [
//                 //   BottomNavigationBarItem(
//                 //       icon: Icon(Icons.home_filled), label: "Home"),
//                 //   BottomNavigationBarItem(
//                 //       icon: Icon(Icons.edit_document), label: "Tasks"),
//                 //   BottomNavigationBarItem(
//                 //       icon: Icon(Icons.computer), label: "Calender"),
//                 //   BottomNavigationBarItem(
//                 //       icon: Icon(Icons.person), label: "Profile"),
//                 // ],
//                  items: [
//                    BottomNavigationBarItem(
//                      icon: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: const [
//                          Align(
//                            alignment: Alignment.topCenter,
//                            child: Icon(Icons.home_filled),
//                          ),
//                          SizedBox(height: 20,),
//                        ],
//                      ),
//                      label: "Home",
//                    ),
//                    BottomNavigationBarItem(

//                      icon: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: const [
//                          Align(
//                            alignment: Alignment.topCenter,
//                            child: Icon(Icons.edit_document),
//                          ),
//                          SizedBox(height: 20,),
//                        ],
//                      ),
//                      label: "Tasks",
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: const [
//                          Align(
//                            alignment: Alignment.topCenter,
//                            child: Icon(Icons.computer),
//                          ),
//                          SizedBox(height: 20,),
//                        ],
//                      ),
//                       label: "Calendar",
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: const [
//                          Align(
//                            alignment: Alignment.topCenter,
//                            child: Icon(Icons.person),
//                          ),
//                          SizedBox(height: 20,),
//                        ],
//                      ),
//                      label: "Profile",
//                    ),
//                  ],
//               ),
//               ),
//             ),
//           ),
//           // Column(
//           //   children: [
//           //     Row(),
//           //     Expanded(
//           //       child: Container(
//           //         color: Colors.white,
//           //       ),
//           //     ),
//           //   ],
//           // ),

//         ],

//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/common/utils.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/auth.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:edusphere/presentation/widgets/hidden_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edusphere/presentation/screens/acadcal.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/profile.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  navigate() {}
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorSecondary: const Color.fromARGB(255, 67, 95, 255),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromARGB(255, 56, 56, 56),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorSecondary: const Color.fromARGB(255, 67, 95, 255),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromARGB(255, 56, 56, 56),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.edit_document),
          title: "Tasks",
          activeColorSecondary: const Color.fromARGB(255, 67, 95, 255),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromARGB(255, 56, 56, 56),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_today_rounded),
          title: "Calender",
          activeColorSecondary: const Color.fromARGB(255, 67, 95, 255),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromARGB(255, 56, 56, 56),
        ),
      ];
    }

    List<Widget> _buildScreens() {
      return [
        const HomePage1(),
        const decider(),
        const HiddenDrawer(),
        const acadcalender(),
      ];
    }

    return Container(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 10),
      decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
        const BoxShadow(
          offset: Offset(-6, 6),
          color: Colors.white,
          blurRadius: 12,
          spreadRadius: 1,
        ),
        const BoxShadow(
          offset: Offset(6, 6),
          color: Colors.white,
          blurRadius: 12,
          spreadRadius: 1,
        ),
        BoxShadow(
          offset: const Offset(0, 6),
          color: Colors.grey.shade500,
          blurRadius: 4,
          spreadRadius: 1,
        ),
      ]),
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 10, right: 00, left: 00),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.grey.shade100,
            //const Color.fromARGB(
            // 255, 255, 255, 255),
            // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: const NavBarDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              colorBehindNavBar: Color.fromARGB(255, 255, 255, 255),
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style7, // Choose the nav bar style with this property.
          ),
        ),
      ),
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  String? role;
  Getrollno xc = Getrollno();

  void signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigator.pushNamedAndRemoveUntil(
      //           context,
      //           '/splash',
      //           (route) => false,
      //           arguments: RouteSettings(
      //             name: '/splash',
      //             arguments: 'Remove History',
      //           ),
      //         );
      // popAllScreens(context);
      //Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthPage()));
      pushNewScreen(context, screen: const AuthPage(), withNavBar: false);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // print("logout");
  // FirebaseAuth.instance.signOut();

  //Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  //Navigator.pushNamed(context, '/splash');
  User? user = FirebaseAuth.instance.currentUser;
  List<String> Subjects = ["Mathematics", "English", "Science", "Social"];
  List<DocumentSnapshot>? teacherList = [];
  List<DocumentSnapshot>? teacherListx = [];
  List<DocumentSnapshot>? teacherListy = [];
  int count = 0;
  int cx = 0;
  List<DocumentSnapshot>? teacherList2;
  Future<void> retrieveTeachers() async {
    xc.getrn();
    GetUserNamee gr = GetUserNamee();
    role = await gr.getRole();
    z = "${user!.email}";
    Getname gn = Getname();
    z = await gn.getRole();

    if (role == "student") {
      Getteacherdocs teacherDocs = Getteacherdocs();
      teacherList = await teacherDocs.getteacher();
      cx = 1;
    } else if (role == "teacher") {
      x = "Classes";
      y = "Students";
      cx = 1;
      Getstudentdocs gs = Getstudentdocs();
      teacherList = await gs.getteacher();
      Subjects = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1"];
      print("nnnnnnnnnnnnnnnnnnnnn");
      print("$teacherList");
    } else if (role == "principal") {
      x = "Classes";
      y = "Students";
      cx = 1;
      Getstudentdocs gs = Getstudentdocs();
      teacherList = await gs.getteacher();

      Getteacherdocs teacherDocs = Getteacherdocs();
      teacherList2 = await teacherDocs.getteacher();

      Subjects = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1"];
      print("nnnnnnnnnnnnnnnnnnnnn");
      print("${teacherList!.length}");
    }
    if (teacherList != null && count == 0) {
      setState(() {
        teacherList = teacherList;
        teacherList2 = teacherList2;
        teacherListx = teacherList;
        teacherListy = teacherList2;
        count = 1;
        cx = 1;
      });
    }
    if (user!.email != z && countt == 0) {
      setState(() {
        z = z;
        countt = 1;
        cx = 1;
      });
    }
  }

  int countt = 0;

  void runFilter(String search) {
    List<DocumentSnapshot>? newteacherList = [];
    if (role == "student") {
      if (search.isEmpty) {
        newteacherList = teacherList;
      } else {
        newteacherList = teacherList
            ?.where((user) => user['first_name']
                .toString()
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }
      setState(() {
        teacherList = newteacherList;
      });
    }
    if (role == "teacher") {
      if (search.isEmpty) {
        newteacherList = teacherList;
      } else {
        newteacherList = teacherList
            ?.where((user) => user['name']
                .toString()
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }
      setState(() {
        teacherList = newteacherList;
      });
    }
  }

  void runFilter2(String search, String bar) {
    print(search);
    print(bar);

    List<DocumentSnapshot>? newteacherList = [];
    List<DocumentSnapshot>? newteacherListb = [];
    if (bar == "student") {
      if (search.isEmpty) {
        newteacherList = teacherListx;
      } else {
        newteacherList = teacherList
            ?.where((user) => user['name']
                .toString()
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }
      setState(() {
        teacherList = newteacherList;
      });
    }
    if (bar == "teacher") {
      if (search.isEmpty) {
        newteacherListb = teacherListy;
      } else {
        newteacherListb = teacherList2
            ?.where((user) => user['first_name']
                .toString()
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }
      setState(() {
        teacherList2 = newteacherListb;
      });
    }
  }

  String x = "Subjects";
  String y = "Teachers";
  String? z;
  @override
  Widget build(BuildContext context) {
    retrieveTeachers();
    if (count == 1 && cx == 1 && role != "principal")
      return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   leading: Container(),
        //   elevation: 0,
        //   toolbarHeight: 160,
        //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
        //   actions: [
        //     IconButton(
        //         onPressed: signUserOut, icon: const Icon(Icons.logout_rounded))
        //   ],
        //   flexibleSpace: Container(
        //     padding: EdgeInsets.only(top: 80, left: 25),
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(50),
        //         bottomRight: Radius.circular(50),
        //       ),
        //       gradient: LinearGradient(
        //         colors: [
        //           Color.fromRGBO(104, 112, 255, 1),
        //           Color.fromRGBO(114, 120, 243, 0.6),
        //         ],
        //       ),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text(
        //           "Hello,",
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: 22.5,
        //             color: Color.fromARGB(164, 255, 255, 255),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 3,
        //         ),
        //         Text(
        //           "$z",
        //           style: const TextStyle(
        //             fontFamily: 'Poppins',
        //             fontWeight: FontWeight.w500,
        //             fontSize: 25.5,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 220,
                child: AppBar(
                  leading: Container(),
                  elevation: 0,
                  toolbarHeight: 200,
                  backgroundColor: Color.fromARGB(0, 224, 224, 224),
                  actions: [
                    IconButton(
                        onPressed: signUserOut,
                        icon: const Icon(Icons.logout_rounded))
                  ],
                  flexibleSpace: Container(
                    height: 200,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 80, left: 25, bottom: 40),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
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
                          "${z!.length<16 ? z : z!.substring(0,16)}",
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
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              x,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Subjects.map((e) => Cardclass(subs: e))
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              y,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation2(
                            1.6,
                            Container(
                              margin: const EdgeInsets.all(20),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
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
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      onChanged: (value) => runFilter(value),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                        hintText: "Search",
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color:
                                              Color.fromRGBO(93, 101, 255, 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: teacherList!
                                        .map((e) => list(doc: e, role: role))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            context),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    else if (role == "principal") {
      print("Prinviprinciprinci");
      return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   leading: Container(),
        //   elevation: 0,
        //   toolbarHeight: 160,
        //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
        //   actions: [
        //     IconButton(
        //         onPressed: signUserOut, icon: const Icon(Icons.logout_rounded))
        //   ],
        //   flexibleSpace: Container(
        //     padding: EdgeInsets.only(top: 80, left: 25),
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(50),
        //         bottomRight: Radius.circular(50),
        //       ),
        //       gradient: LinearGradient(
        //         colors: [
        //           Color.fromRGBO(104, 112, 255, 1),
        //           Color.fromRGBO(114, 120, 243, 0.6),
        //         ],
        //       ),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text(
        //           "Hello,",
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: 22.5,
        //             color: Color.fromARGB(164, 255, 255, 255),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 3,
        //         ),
        //         Text(
        //           "$z",
        //           style: const TextStyle(
        //             fontFamily: 'Poppins',
        //             fontWeight: FontWeight.w500,
        //             fontSize: 25.5,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 200,
                child: AppBar(
                  leading: Container(),
                  elevation: 0,
                  toolbarHeight: 150,
                  backgroundColor: Color.fromARGB(0, 224, 224, 224),
                  actions: [
                    IconButton(
                        onPressed: signUserOut,
                        icon: const Icon(Icons.logout_rounded))
                  ],
                  flexibleSpace: Container(
                    height: 170,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 80, left: 25, bottom: 40),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
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
                          "$z",
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
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Classes",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Subjects.map((e) => Cardclass(subs: e))
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Students",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation2(
                            1.6,
                            Container(
                              margin: const EdgeInsets.all(20),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
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
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      onChanged: (value) =>
                                          runFilter2(value, "student"),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                        hintText: "Search",
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color:
                                              Color.fromRGBO(93, 101, 255, 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: teacherList!
                                        .map((e) =>
                                            list(doc: e, role: "teacher"))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            context),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Teachers",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation2(
                            1.6,
                            Container(
                              margin: const EdgeInsets.all(20),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
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
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      onChanged: (value) =>
                                          runFilter2(value, "teacher"),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                        hintText: "Search",
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color:
                                              Color.fromRGBO(93, 101, 255, 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: teacherList2!
                                        .map((e) =>
                                            list(doc: e, role: "principal"))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            context),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      //return const Placeholder();
    } else
      return Loading();
  }
}
