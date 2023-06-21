import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class GetSyllabus extends StatefulWidget {
  String collecti;
  GetSyllabus({super.key, required this.collecti});

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
        backgroundColor: Color.fromRGBO(148, 153, 255, 1),
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
                  child: ListTile(
                    title: Text(" Chapter $key : ${value.toString()}"),
                  ),
                );
              })
          : Loading(),
    );
  }
}
