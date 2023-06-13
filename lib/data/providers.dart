import 'package:cloud_firestore/cloud_firestore.dart';
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
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(documentId).get();
    if (snapshot.exists) {
      Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
      if (data['email'] == user!.email) {
        return data['role'];
      }
    }
    return null;
  }
}




class GetUserNamee {
  // final String documentId;
  // GetUserNamee({required this.documentId});

  Future<String?> getRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await users.where('email', isEqualTo: user!.email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = snapshot.docs.first;
      return doc['role'] as String?;
    }
    return null;
  }
}
