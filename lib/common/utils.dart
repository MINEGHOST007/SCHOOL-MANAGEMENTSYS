// import 'package:flutter/material.dart';
//
// GestureDetector containerToButton({
//   required Widget child,
//   required VoidCallback onPressed,
//   Color? color,
//   EdgeInsetsGeometry? padding,
//   BorderRadiusGeometry? borderRadius,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: Container(
//       decoration: BoxDecoration(
//         color: color ?? Colors.transparent,
//         borderRadius: borderRadius,
//       ),
//       padding: padding,
//       child: child,
//     ),
//   );
// }

// import 'package:flutter/material.dart';
//
// class ContainerWithGesture extends StatelessWidget {
//   final Widget child;
//   final GestureTapCallback onTap;
//
//   const ContainerWithGesture({
//     Key? key,
//     required this.child,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         child: child,
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/acadcal.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/profile.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:pie_chart/pie_chart.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTile({Key? key, required this.imagePath, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}

// class ColorChange extends StatefulWidget {
//   const ColorChange({super.key});

//   @override
//   State<ColorChange> createState() => _ColorChangeState();
// }

// class _ColorChangeState extends State<ColorChange> {
//   Color _contcolor1 = const Color.fromRGBO(183, 194, 255, 1);
//   Color _contcolor2 = const Color.fromRGBO(183, 194, 255, 1);
//   void changeColor1() {
//     _contcolor1 = const Color.fromRGBO(54, 84, 255, 1);
//     _contcolor2 = const Color.fromRGBO(183, 194, 255, 1);
//     print("CREATE ACCOUYNT");
//   }
//     void changeColor2() {
//     _contcolor2 = const Color.fromRGBO(54, 84, 255, 1);
//     _contcolor1 = const Color.fromRGBO(183, 194, 255, 1);
//     print("CREATE ACCOUYNT");
//   }
// }

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Color.fromARGB(255, 67, 95, 255),
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: Color.fromARGB(255, 67, 95, 255),
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.edit_document),
          title: "Tasks",
          activeColorPrimary: Color.fromARGB(255, 67, 95, 255),
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.calendar_view_month_outlined),
          title: "Calender",
          activeColorPrimary: Color.fromARGB(255, 67, 95, 255),
          inactiveColorPrimary: Colors.black,
        ),
      ];
    }

    List<Widget> _buildScreens() {
      return [
        HomePage(),
        Profilepage(),
        tasks(),
        acadcalender(),
      ];
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
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
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}

class Cardclass extends StatefulWidget {
  Cardclass({super.key, required this.subs});
  String subs;


  @override
  State<Cardclass> createState() => _CardclassState();
}

class _CardclassState extends State<Cardclass> {
  String? role = "student";



  void getRole2() async {
    GetUserNamee gr = GetUserNamee();
    role = await gr.getRole();
    if (role == "teacher") {
      setState(() {
        role = role;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole2();
  }

  void getRole(BuildContext context) async {
    GetUserNamee gr = GetUserNamee();
    role = await gr.getRole();
    clickcard(context);
  }

  void clickcard(BuildContext context) {
    print(role);
    if (role == "student") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GetSyllabus(collecti: widget.subs, role: role)),
      );
    } else if (role == "teacher") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetSubjects(cls: widget.subs),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
  Color xx = const Color.fromRGBO(143, 148, 251, 0.6);
  Color yy = const Color.fromRGBO(143, 148, 251, 1);  
    if (role == "teacher") {
      return GestureDetector(
        onTap: () => {getRole(context)},
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 20),
          height: 120,
          width: 120,
          margin: EdgeInsets.only(right: 15),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
              border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0),width: 2, style: BorderStyle.solid),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/${widget.subs}.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => {getRole(context)},
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 20),
          height: 170,
          width: 120,
          margin: EdgeInsets.only(right: 15),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, 0.6),
            ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/${widget.subs}.png',
                fit: BoxFit.contain,
              ),
              Text(
                widget.subs,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class Cardclass2 extends StatelessWidget {
  Cardclass2({super.key, required this.subs, required this.cls});
  String subs;
  String cls;
  String? role = "student";
  void getRole() async {
    GetUserNamee gr = GetUserNamee();
    role = await gr.getRole();
  }

  void clickcard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GetSyllabus2(collecti: subs, cls: cls)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {clickcard(context)},
      child: Container(
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 20),
          height: 120,
          width: 280,
          margin: EdgeInsets.only(right: 15),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, 0.6),
            ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/${subs}.png',
                fit: BoxFit.contain,
              ),
              Text(
                subs,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class list extends StatelessWidget {
  DocumentSnapshot doc;
  String? role;
  list({super.key, required this.doc, required this.role});

  @override
  Widget build(BuildContext context) {
    print('ttttttttttttttttttttttttttt');
    print(doc);
    if (role == "student") {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 500,
        height: 75,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromARGB(0, 0, 0, 0), style: BorderStyle.solid)),
        child: Row(
          children: [
            Image.asset(
              'assets/images/teacher.png',
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doc['first_name'],
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        doc['second_name'],
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(doc['email']),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      double att = doc['present'] * 100 / (doc['absent'] + doc['present']);
      double x = doc['present'] / 1;
      double y = doc['absent'] / 1;
      Map<String, double> dataMap = {
        'Present': x,
        'Absent': y,
      };
      void clickprofile(Map<String, double> dataMapx, DocumentSnapshot docx) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Getprofile(pie: dataMapx, doc: docx)),
        );
      }

      return GestureDetector(
        onTap: () {
          clickprofile(dataMap, doc);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 500,
          height: 75,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(0, 0, 0, 0), style: BorderStyle.solid)),
          child: Row(
            children: [
              Image.asset(
                'assets/images/teacher.png',
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          doc['name'],
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(doc['email']),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
