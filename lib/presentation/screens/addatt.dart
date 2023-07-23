import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/common/utils.dart';
import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:edusphere/data/absentee_list.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class addAtt extends StatefulWidget {
  const addAtt({super.key});

  @override
  State<addAtt> createState() => _addAttState();
}

class _addAttState extends State<addAtt> {
  int? cls;
  String ff = "Choose Date";
  DateTime? dd;
  List<DocumentSnapshot>? teacherList = [];
  String? role = "teacher";

  void showdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        ff = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }

  Future<void> retreive() async {
    Getstudentdocs gs = Getstudentdocs();
    teacherList = await gs.getteacher();
    if (teacherList != null) {
      setState(() {
        teacherList = teacherList;
      });
    }
  }

  void runFilter(String search) {
    List<DocumentSnapshot>? newteacherList = [];
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

  Updateatt xc = Updateatt();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retreive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Select class",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                Center(
                  child: DropdownButton<int>(
                    value: cls,
                    hint: Text('select class'),
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
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    "Select Date : ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("SIGN UP");
                    // filepick();
                    showdatepicker();
                  },
                  child: Container(
                    width: 150,
                    height: 60,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Container(
                      width: 180,
                      height: 77.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromRGBO(117, 123, 255, 1),
                      ),
                      child: Center(
                        child: Text(
                          ff,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Select Absentees",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: "Search",
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(93, 101, 255, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: teacherList!
                                .map((e) => listz(doc: e, role: role))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    context),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  print("xxxxxxxxxxxxxxxx"),
                  xc.upp(absentee, ff),
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 60),
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(0, 224, 224, 224),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CircularPercentIndicator(
                                  radius: 28,
                                  lineWidth: 10,
                                  progressColor:
                                      Color.fromRGBO(110, 118, 255, 1),
                                  backgroundColor:
                                      Color.fromRGBO(162, 166, 255, 1),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Icon(
                                    Icons.done_all_outlined,
                                    color: Color.fromRGBO(110, 118, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  })
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
                      // border: Border.all(color: Colors.white, width: 2),
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
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class addteachatt extends StatefulWidget {
  const addteachatt({super.key});

  @override
  State<addteachatt> createState() => _addteachattState();
}

class _addteachattState extends State<addteachatt> {
  int? cls;
  String ff = "Choose Date";
  DateTime? dd;
  List<DocumentSnapshot>? teacherList = [];
  List<DocumentSnapshot>? teacherListx = [];
  String? role = "teacher";

  void showdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        ff = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }

  Future<void> retreive() async {
    Getteacherdocs gs = Getteacherdocs();
    teacherList = await gs.getteacher();
    if (teacherList != null) {
      setState(() {
        teacherList = teacherList;
        teacherListx = teacherList;
      });
    }
  }

  void runFilter(String search) {
    List<DocumentSnapshot>? newteacherList = [];
    if (search.isEmpty) {
      newteacherList = teacherListx;
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

  Updateatt xc = Updateatt();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retreive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    "Select Date : ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("SIGN UP");
                    // filepick();
                    showdatepicker();
                  },
                  child: Container(
                    width: 150,
                    height: 60,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Container(
                      width: 180,
                      height: 77.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromRGBO(117, 123, 255, 1),
                      ),
                      child: Center(
                        child: Text(
                          ff,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Select Present",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: "Search",
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(93, 101, 255, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: teacherList!
                                .map((e) => listb(doc: e, role: role))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    context),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  print("xxxxxxxxxxxxxxxx"),
                  xc.upp(absentee, ff),
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 60),
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(0, 224, 224, 224),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CircularPercentIndicator(
                                  radius: 28,
                                  lineWidth: 10,
                                  progressColor:
                                      Color.fromRGBO(110, 118, 255, 1),
                                  backgroundColor:
                                      Color.fromRGBO(162, 166, 255, 1),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Icon(
                                    Icons.done_all_outlined,
                                    color: Color.fromRGBO(110, 118, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  })
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
                      // border: Border.all(color: Colors.white, width: 2),
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
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
