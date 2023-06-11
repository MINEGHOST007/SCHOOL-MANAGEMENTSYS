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

import 'package:edusphere/presentation/screens/acadcal.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/profile.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

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
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
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
