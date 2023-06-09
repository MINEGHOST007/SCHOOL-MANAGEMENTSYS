import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/addass.dart';
import 'package:edusphere/presentation/screens/addatt.dart';
import 'package:edusphere/presentation/screens/attendance.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Assignments',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          tasks()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Attendance',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          Attendance()),
    ];
    getrole();
  }

  String? role;
  void getrole() async {
    GetUserNamee gu = GetUserNamee();
    role = await gu.getRole();
    if(role != null)
    setState(() {
      role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (role == "teacher") {
      pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Your Assignments',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          tasks()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Attendance',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          Attendance()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Assignments',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          Addass()),
                ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Attendance',
              baseStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
          addAtt()),
    ];
    }
    return HiddenDrawerMenu(
      backgroundColorAppBar: Color.fromRGBO(109, 116, 255, 1),
      isTitleCentered: true,
      backgroundColorMenu: Color.fromRGBO(144, 150, 255, 0.749),
      screens: pages,
      initPositionSelected: 0,
      slidePercent: 55,
      backgroundColorContent: Color.fromARGB(0, 0, 0, 0),
    );
  }
}
