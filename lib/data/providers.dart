import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/common/utils.dart';
import 'package:edusphere/presentation/screens/Editprofile.dart';
import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class GetUserName extends StatefulWidget {
  final String documentId;
  GetUserName({required this.documentId});

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder: (context, value) {
          if (value.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                value.data!.data() as Map<String, dynamic>;
            return Text('role: ${data['role']} email: ${data['email']}');
          }
          return Text('loading...');
        });
  }
}

String Streamget(String? email, List<String> DocIds) {
  String role = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  for (int i = 0; i < DocIds.length; i++) {
    users.doc(DocIds[i]).get().then((value) {
      print('letsssssssssssssssssssss');
      print(value);
      if (value.exists) {
        Map<String, dynamic> dataaa = value.data() as Map<String, dynamic>;
        if (dataaa['email'] == email) ;
        role = dataaa['role'];
      }
    });
  }
  return role;
}

Stream<String> getRoleStream(String? email, List<String> docIds) {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  return Stream.fromIterable(docIds).asyncMap((docId) async {
    final DocumentSnapshot docSnapshot = await users.doc(docId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data['email'] == email) {
        return data['role'];
      }
    }
    return '';
  });
}

class GetUserNameee {
  final String documentId;
  GetUserNameee({required this.documentId});

  Future<String?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(documentId).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['email'] == user!.email) {
        return data['role'];
      }
    }
    return null;
  }
}

// class GetClass {
//   final String documentId;
//   GetClass({required this.documentId});

//   Future<int?> getRole() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     DocumentSnapshot snapshot = await users.doc(documentId).get();
//     if (snapshot.exists) {
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//       if (data['email'] == user!.email) {
//         return data['class'];
//       }
//     }
//     return null;
//   }
// }

class Getsyl {
  String documentId;
  String coll;
  Getsyl({required this.documentId, required this.coll});

  Future<Map<String, dynamic>?> getRole() async {
    CollectionReference users = FirebaseFirestore.instance.collection(coll);

    DocumentSnapshot snapshot = await users.doc(documentId).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    }
    return null;
  }
}

class GetUserNamee {
  // final String documentId;
  // GetUserNamee({required this.documentId});

  Future<String?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      return doc['role'] as String?;
    }
    return null;
  }
}

class Getattendance {
  // final String documentId;
  // GetUserNamee({required this.documentId});

  Future<double?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      print(doc['present']);
      int? x = doc['present'] as int?;
      int? y = doc['absent'] as int?;
      double attendance = (x! * 100) / (x + y!);
      return attendance;
    }
    return null;
  }
}

class Getclass {
  // final String documentId;
  // GetUserNamee({required this.documentId});

  Future<String?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      return doc['class'] as String?;
    }
    return null;
  }
}

class Getname {
  // final String documentId;
  // GetUserNamee({required this.documentId});

  Future<String?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      if (doc['role'] == "student")
        return doc['name'] as String?;
      else {
        String? fn = "${doc['first_name']} ${doc['second_name']}";
        return fn;
      }
    }
    return null;
  }

    Future<String?> getRolefirst() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      if (doc['role'] == "student")
        return doc['name'] as String?;
      else {
        String? fn = "${doc['first_name']}";
        return fn;
      }
    }
    return null;
  }
}

class Updatename {
  // final String documentId;
  // GetUserNamee({required this.documentId});
  String? name;
  int? cls;
  Updatename({required this.cls, required this.name});

  void getRole() async {
    String? dup = "$cls";
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      doc.reference
          .update({'name': name, 'class': dup})
          .then((value) => print('added to document ${doc.id}'))
          .catchError((error) => print('Error document ${doc.id}: $error'));
    }
  }
}

class Updatename3 {
  // final String documentId;
  // GetUserNamee({required this.documentId});
  String? fname;
  String? sname;
  int? cls;
  Updatename3({required this.fname, required this.sname});

  void getRole() async {
    String? dup = "$cls";
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      doc.reference
          .update({'first_name': fname, 'second_name': sname})
          .then((value) => print('added to document ${doc.id}'))
          .catchError((error) => print('Error document ${doc.id}: $error'));
    }
  }
}

class Updatename2 {
  // final String documentId;
  // GetUserNamee({required this.documentId});
  int name;
  int cls;
  Updatename2({required this.cls, required this.name});

  void getRole(String email) async {
    print(email);
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(name);
    print(cls);
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot = await users.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      doc.reference
          .update({'absent': name, 'present': cls})
          .then((value) => print('added to document ${doc.id}'))
          .catchError((error) => print('Error document ${doc.id}: $error'));
    }
  }
}

class Getteacherdocs {
  Future<List<DocumentSnapshot>> getteacher() async {
    List<DocumentSnapshot> teachers = [];
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot snapshot =
        await users.where('role', isEqualTo: "teacher").get();
    teachers = snapshot.docs.toList();
    print(teachers);
    return teachers;
  }
}








class Getstudentdocs {
  Future<List<DocumentSnapshot>> getteacher() async {
    List<DocumentSnapshot> teachers = [];
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot snapshot =
        await users.where('role', isEqualTo: "student").get();
    teachers = snapshot.docs.toList();
    print(teachers);
    return teachers;
  }
}

class Getrollno {
  Future<int?> getrn() async {
    List<DocumentSnapshot>? studentList = [];
    Getstudentdocs gs = Getstudentdocs();
    studentList = await gs.getteacher();

    for (int i = 0; i < studentList.length; i++) {
      DocumentSnapshot docx = studentList[i];
      int roll = i;
      docx.reference
          .update({'roll': roll})
          .then((value) => print('Roll number added to document ${docx.id}'))
          .catchError((error) =>
              print('Error adding roll number to document ${docx.id}: $error'));
    }

    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      return doc['roll'] as int?;
    }
    return null;
  }
}

class GetSyllabus extends StatefulWidget {
  String collecti;
  String? role;
  GetSyllabus({super.key, required this.collecti, required this.role});

  @override
  State<GetSyllabus> createState() => _GetSyllabusState();
}

class _GetSyllabusState extends State<GetSyllabus> {
  Map<String, dynamic>? data;
  CollectionReference Subject = FirebaseFirestore.instance.collection("none");
  Getclass gc = Getclass();
  int count = 0;
  void Getdocs() async {
    Subject = await FirebaseFirestore.instance.collection(widget.collecti);

    if (Subject != null) {
      String? cls = await gc.getRole();
      if (cls != null && count == 0) {
        Getsyl gs = Getsyl(documentId: cls, coll: widget.collecti);
        data = await gs.getRole();
        print(data);
        setState(() {
          data = data;
          count = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Getdocs();

    return Scaffold(
      appBar: AppBar(
        title: Text("Syllabus"),
        backgroundColor: Color.fromRGBO(109, 116, 255, 1),
      ),
      backgroundColor: Colors.grey[300],
      body: data != null
          ? ListView.builder(
              itemCount: data?.length,
              itemBuilder: (BuildContext context, int index) {
                var key = data!.keys.elementAt(index);
                var value = data![key];
                return Container(
                  margin: EdgeInsets.only(top:15,bottom: 5,left: 15,right: 15),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(27)),
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
                  ),
                  child: ListTile(
                    title: Text(" Chapter $key : ${value.toString()}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    ),
                  ),
                );
              })
          : Loading(),
    );
  }
}

class GetSubjects extends StatelessWidget {
  String cls;
  GetSubjects({super.key, required this.cls});

  List<String> subjects = ["Mathematics", "English", "Social", "Science"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Subjects",
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Color.fromRGBO(109, 116, 255, 1),
          leading: Container(),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Perform the desired action to navigate to the home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage1()),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: subjects
                      .map((e) => Cardclass2(subs: e, cls: cls))
                      .toList(),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetSyllabus2 extends StatefulWidget {
  String collecti;
  String cls;
  GetSyllabus2({super.key, required this.collecti, required this.cls});

  @override
  State<GetSyllabus2> createState() => _GetSyllabus2State();
}

class _GetSyllabus2State extends State<GetSyllabus2> {
  Map<String, dynamic>? data;
  CollectionReference Subject = FirebaseFirestore.instance.collection("none");
  Getclass gc = Getclass();
  int count = 0;
  void Getdocs() async {
    Subject = await FirebaseFirestore.instance.collection(widget.collecti);

    if (Subject != null) {
      String? cls = widget.cls;
      if (count == 0) {
        Getsyl gs = Getsyl(documentId: cls, coll: widget.collecti);
        data = await gs.getRole();
        print(data);
        setState(() {
          data = data;
          count = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Getdocs();
    return Scaffold(
      appBar: AppBar(
        title: Text("Syllabus"),
        backgroundColor: Color.fromRGBO(74, 83, 255, 1),
      ),
      backgroundColor: Color.fromARGB(230, 177, 177, 177),
      body: data != null
          ? ListView.builder(
              itemCount: data?.length,
              itemBuilder: (BuildContext context, int index) {
                var key = data!.keys.elementAt(index);
                var value = data![key];
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(" Chapter $key : ${value.toString()}"),
                      ),
                    ],
                  ),
                  
                );
              })
          : Loading(),
          
    );
  }
}

class Getprofile extends StatefulWidget {
  Map<String, double> pie;
  DocumentSnapshot doc;
  Getprofile({super.key, required this.pie, required this.doc});

  @override
  State<Getprofile> createState() => _GetprofileState();
}

class _GetprofileState extends State<Getprofile> {
  Future<void> refresh() async {
    List<DocumentSnapshot>? teacherList = [];
    Getstudentdocs gs = Getstudentdocs();
    teacherList = await gs.getteacher();
    print("refresssssssssssssssssssss");
    if (teacherList != null) {
      setState(() {
        print("refresssssssssssssssssssss");
        teacherList = teacherList!
            .where((user) => user['email']
                .toString()
                .toLowerCase()
                .contains(widget.doc['email'].toLowerCase()))
            .toList();
        widget.doc = teacherList!.first;
        print(widget.doc['present']);

        widget.pie = {
          'Present': widget.doc['present'] / 1,
          'Absent': widget.doc['absent'] / 1,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Student Profile"),
        backgroundColor: Color.fromARGB(255, 98, 122, 255),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 47.5,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Editpage2(email: widget.doc['email'])),
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    //border: Border.all(color: Colors.white, width: 2),
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
                                  ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Edit Attendance",
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
                    height: 35,
                  ),
            Container(
              width: 500,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
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
                                  ]
                  ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name : ${widget.doc['name']}",
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
                        "Class : ${widget.doc['class']}",
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Roll No : ${widget.doc['roll']} ",
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
                    child: PieChart(dataMap: widget.pie,colorList: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                      ],),
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
                        Color.fromRGBO(143, 148, 251, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                  ]
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
  }
}
