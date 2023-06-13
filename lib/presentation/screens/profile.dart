// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Profilepage extends StatefulWidget {
//   const Profilepage({super.key});

//   @override
//   State<Profilepage> createState() => _ProfilepageState();
// }

// class _ProfilepageState extends State<Profilepage> {
//   String role = "letsgetoutofhere";
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   User? user = FirebaseAuth.instance.currentUser;

//   void fetchdata() async {
//     if (user != null) {
//       String uid = user!.uid;
//       DocumentSnapshot snapshot = firestore.collection('users').doc(uid).get() as DocumentSnapshot<Object?>;
//       print('object');
//       print(snapshot.data());

//       if (snapshot.exists) {
//       } else {}
//     }
//     //DocumentSnapshot snapshot = await firestore.collection('users').doc(user.).get();
//     //print(snapshot);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (role == "teacher") {
//       return const Scaffold(
//         body: Center(
//           child: Text("You are logged in as Teacher"),
//         ),
//       );
//     } else {
//       print("letsssssssssssssssssssssssssssssssssssssssssssss");
//       print(user);
//       fetchdata();
//       return const Scaffold(
//         body: Center(
//           child: Text("You are logged in as Student"),
//         ),
//       );
//     }
//   }
// }

import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/load.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  List<String> docIDs = [];

  String? role = "letsgetoutofhere";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach((element) async {
            print(element.reference.id);
            docIDs.add(element.reference.id);
            // GetUserNameee getuser =
            //     GetUserNameee(documentId: element.reference.id);
            // role = await getuser.getRole();
          }),
        );
  }

  int count = 0;
  Future getDocId2() async {
    String? roleee;
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach((element) async {
            print(element.reference.id);
            //docIDs.add(element.reference.id);
            // GetUserNamee getuser =
            //     GetUserNamee(documentId: element.reference.id);
            GetUserNamee getuser =
                GetUserNamee();
            role = await getuser.getRole();
            print(
                'letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
            print(role);
            if (role != "letsgetoutofhere" && count == 0) {
              setState(() {
                role = role;
                count = 1;
              });
            }
          }),
        );
  }

  @override
  void initState() {
    super.initState();
    //getDocId2();
  }

  @override
  Widget build(BuildContext context) {
    // String? email = user!.email;
    // //role = getRoleStream(email, docIDs) as String;
    // role = Streamget(email, docIDs);
    getDocId2();
    if (count == 0) {
      return Loading();
    }
    print('letsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    print(role);
    if (role == "student") {
      return const Scaffold(
        body: Center(
          child: Text("You are logged in as Student"),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text('You are logged in as Teacher'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, value) {
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GetUserName(
                              documentId: docIDs[index],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}
