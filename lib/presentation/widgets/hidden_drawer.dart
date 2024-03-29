import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/addass.dart';
import 'package:edusphere/presentation/screens/addatt.dart';
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
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const tasks()),
          ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Notices',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const notices()),
    ];
    getrole();
  }

  String? role;
  void getrole() async {
    GetUserNamee gu = GetUserNamee();
    role = await gu.getRole();
    if(role != null) {
      setState(() {
      role = role;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role == "teacher") {
      pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Your Assignments',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const tasks()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Assignments',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const Addass()),
                ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Attendance',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const addAtt()),
          ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Notices',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const notices()),
    ];
    }
    else if(role == "principal"){
            pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Your Notices',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const notices()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Notices',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const deciderrr()),
                ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Add Attendance',
              baseStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              selectedStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          const addteachatt()),
    ];
    }
    return HiddenDrawerMenu(
      backgroundColorAppBar: const Color.fromRGBO(109, 116, 255, 1),
      isTitleCentered: true,
      backgroundColorMenu: const Color.fromRGBO(144, 150, 255, 0.749),
      screens: pages,
      initPositionSelected: 0,
      slidePercent: 55,
      backgroundColorContent: const Color.fromARGB(0, 0, 0, 0),
    );
  }
}
