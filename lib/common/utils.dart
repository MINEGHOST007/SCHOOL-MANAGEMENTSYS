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

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/acadcal.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:edusphere/presentation/screens/profile.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

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
                color: Color.fromARGB(255, 0, 0, 0),
                width: 2,
                style: BorderStyle.solid),
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

class GetAss {
  // GetUserNamee gr = GetUserNamee();

  // String? x;
  // Future<List<DocumentSnapshot>?> gett() async {
  //   List<DocumentSnapshot> fass = [];
  //   List<DocumentSnapshot> assg = [];
  //   String? role = await gr.getRole();
  //   if (role == "student") {
  //     Getteacherdocs gd = Getteacherdocs();
  //     List<DocumentSnapshot> docc = await gd.getteacher();
  //     Getclass gc = Getclass();
  //     String? cls = await gc.getRole();
  //     if (cls != null) {
  //       docc.map((e) => {
  //             assg = getcoll(e, cls) as List<DocumentSnapshot>,
  //             fass.addAll(assg)
  //           });
  //       if (fass != null) {
  //         print(fass);
  //         print("fass");

  //       }
  //     }
  //   } else {}
  // }

  // Future<List<DocumentSnapshot>> getcoll(
  //     DocumentSnapshot doc, String? cls) async {
  //   List<DocumentSnapshot> asse = [];
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection("${doc['first_name']}");
  //   QuerySnapshot snapshot =
  //       await users.where('class', isEqualTo: "$cls").get();
  //   asse = snapshot.docs.toList();
  //   print("11111111111");
  //   return asse;
  // }

  Future<List<DocumentSnapshot?>?> getassignment() async {
    List<DocumentSnapshot> doc = [];
    List<DocumentSnapshot> fdoc = [];
    Getteacherdocs x = Getteacherdocs();
    List<DocumentSnapshot> y = await x.getteacher();
    print("xxxxxxxxxxxxxxxxxx");
    for (int i = 0; i < y.length; i++) {
      CollectionReference users =
          FirebaseFirestore.instance.collection("${y[i]['first_name']}");
      QuerySnapshot snapshot =
          await users.where('class', isEqualTo: "10").get();
      doc = snapshot.docs.toList();
      fdoc = fdoc + doc;
    }
    if (fdoc != null) return fdoc;
  }

  Future<List<DocumentSnapshot?>?> getassignment2() async {
    List<DocumentSnapshot> doc = [];
    List<DocumentSnapshot> fdoc = [];
    Getteacherdocs x = Getteacherdocs();
    List<DocumentSnapshot> y = await x.getteacher();
    Getname gx = Getname();
    String? zz = await gx.getRolefirst();
    if (zz != null) {
      CollectionReference users = FirebaseFirestore.instance.collection(zz);
      QuerySnapshot snapshot = await users.get();
      doc = snapshot.docs.toList();
      fdoc = fdoc + doc;
      if (fdoc != null) return fdoc;
    }
  }
}

class listAss extends StatefulWidget {
  String? Subject;
  String? topic;
  DateTime? x;
  DateTime? y;
  String? urr;
  String? role;
  //DateTime
  listAss(
      {super.key,
      required this.Subject,
      required this.topic,
      required this.x,
      required this.y,
      required this.urr,
      required this.role});

  @override
  State<listAss> createState() => _listAssState();
}

class _listAssState extends State<listAss> {
  Future<String> uploadpdf(String fn, File file) async {
    final refer =
        FirebaseStorage.instance.ref("Assignments/Hermoine/10/Answers/$fn.pdf");

    final uploadTask = refer.putFile(file);

    await uploadTask.whenComplete(() => {});

    final downlink = await refer.getDownloadURL();

    return downlink;
  }

  void filepicker() async {
    User? user = FirebaseAuth.instance.currentUser;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File("${result.files.single.path}");

      String fn = result.files[0].name;

      final fownload = await uploadpdf(fn, file);

      await FirebaseFirestore.instance.collection("Answers").add({
        "link": fownload,
        "name": "$fn",
        "topic": "${widget.topic}",
        "by": user!.email
      });
    }
  }

  Future<void> downloadfile(String urr, String xx) async {
    var httpClient = http.Client();
    var req = await httpClient.get(Uri.parse(urr));

    var bytes = req.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();

    var file = File("${dir.path}/$xx.pdf");
    print(file);
    await file.writeAsBytes(bytes);
  }

  void status() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference Ans = FirebaseFirestore.instance.collection("Answers");
    QuerySnapshot snapshot = await Ans.where('by', isEqualTo: user!.email)
        .where('topic', isEqualTo: widget.topic)
        .get();

    print(snapshot);

    if (snapshot.docs.isNotEmpty) {
      xo = "Finished";
      xvv = Color.fromARGB(255, 71, 71, 71);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status();
  }

  String xo = "Unfinished";
  Color xvv = Color.fromARGB(255, 148, 109, 255);

  @override
  Widget build(BuildContext context) {
    if (widget.role == "student") {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 20,
              margin: EdgeInsets.only(top: 4, left: 0, bottom: 5),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color.fromARGB(255, 202, 171, 255),
              ),
              child: Center(
                  child: Text(
                "${widget.Subject}",
                style: TextStyle(
                  color: Color.fromARGB(255, 125, 88, 255),
                  fontSize: 10,
                ),
              )),
            ),
            Text(
              "${widget.topic}",
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Assign Date : ",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  "${widget.x}",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last Date : ",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  "${widget.y}",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status : ",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  "$xo",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    filepicker();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: xvv,
                      border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    print("Download"),
                    // downloadfile("${widget.urr}", "${widget.topic}"),
                    FileDownloader.downloadFile(
                      url: "${widget.urr}".trim(),
                    ),
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 148, 109, 255),
                      border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            "Download",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {},
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 20,
                margin: EdgeInsets.only(top: 4, left: 0, bottom: 5),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color.fromARGB(255, 202, 171, 255),
                ),
                child: Center(
                    child: Text(
                  "${widget.Subject}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 125, 88, 255),
                    fontSize: 10,
                  ),
                )),
              ),
              Text(
                "${widget.topic}",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assign Date : ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    "${widget.x}",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Date : ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    "${widget.y}",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetAnswers(topic: widget.topic)),
                  ),
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color.fromARGB(255, 148, 109, 255),
                    border: Border.all(
                        color: Colors.white,
                        width: 3,
                        style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_carousel,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Text(
                          "View Answers",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class GetAnswers extends StatefulWidget {
  String? topic;
  GetAnswers({super.key, required this.topic});

  @override
  State<GetAnswers> createState() => _GetAnswersState();
}

class _GetAnswersState extends State<GetAnswers> {
  List<DocumentSnapshot> docs = [];
  int count = 0;
  void getdata() async {
    CollectionReference Ans = FirebaseFirestore.instance.collection("Answers");
    QuerySnapshot snapshot =
        await Ans.where('topic', isEqualTo: widget.topic).get();

    if (snapshot.docs.isNotEmpty && count == 0) {
      docs = snapshot.docs.toList();
      setState(() {
        docs = docs;
        count = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    print("object");
    if (docs != null)
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Answers to ${widget.topic}"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (value) => value,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            Column(
              children: docs.map((e) => listx(doc: e)).toList(),
            ),
          ],
        ),
      );
    else
      return Loading();
  }
}

class listx extends StatelessWidget {
  DocumentSnapshot doc;
  listx({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 500,
      height: 105,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(0, 0, 0, 0), style: BorderStyle.solid)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/assignment.png',
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
                      "By",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      doc['by'],
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                      doc['name'],
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                GestureDetector(
                  onTap: () => {
                    print("Download"),
                    // downloadfile("${widget.urr}", "${widget.topic}"),
                    FileDownloader.downloadFile(
                      url: "${doc['link']}".trim(),
                    ),
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 148, 109, 255),
                      border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            "Download",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
