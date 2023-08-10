import 'package:edusphere/data/providers.dart';
import 'package:edusphere/presentation/screens/tasks.dart';
import 'package:edusphere/presentation/widgets/animations.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addass extends StatefulWidget {
  const Addass({super.key});

  @override
  State<Addass> createState() => _AddassState();
}

class _AddassState extends State<Addass> {
  String? sub;
  String? top;
  int? cls;
  DateTime? aa;
  DateTime? dd;
  String? urr;

  Color cc = const Color.fromRGBO(117, 123, 255, 1);

  Future<String?> uploadpdf(String fn, File file) async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    if (fnxx != null) {
      final refer = FirebaseStorage.instance
          .ref("Assignments/$fnxx/$cls/$top/Materials/$fn.pdf");

      final uploadTask = refer.putFile(file);

      await uploadTask.whenComplete(() => {});

      final downlink = await refer.getDownloadURL();

      setState(() {
        cc = const Color.fromRGBO(80, 80, 80, 0.8);

        qxx = "Choosed $fn";
      });

      return downlink;
    }
    return null;
  }

  void filepicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File("${result.files.single.path}");

      String fn = result.files[0].name;

      final fownload = await uploadpdf(fn, file);

      urr = "$fownload";

      await FirebaseFirestore.instance
          .collection("Materials")
          .add({"link": fownload, "name": fn, "topic": "$top"});
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

  String qxx = "Choose File";
  String ff = "Choose Date";

  void showdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color.fromRGBO(109, 116, 255, 1),
              colorScheme:
                  const ColorScheme.light(primary: Color.fromRGBO(109, 116, 255, 1)),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    ).then((value) {
      setState(() {
        dd = value;
        if (dd != null) ff = "${dd!.year}/${dd!.month}/${dd!.day}";
      });
    });
  }

  void adds() async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    final db = FirebaseFirestore.instance;
    if (fnxx != null) {
      var ass = {
        "by": fnxx,
        "Subject": sub,
        "Topic": top,
        "assign": DateTime.now(),
        "Deadline": dd,
        "url": urr,
        "class": "$cls"
      };
      db.collection(fnxx).add(ass).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
      showsuccess();
    }
  }

  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Assignment Added',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            FadeAnimation3(
                1.6,
                Container(
                  width: 500,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-6, -6),
                          color: Colors.white,
                          blurRadius: 8,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Subject : ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xFFBDBDBD),
                              )),
                            ),
                            child: TextField(
                              onChanged: (value) => sub = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Subject ",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Topic : ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xFFBDBDBD),
                              )),
                            ),
                            child: TextField(
                              onChanged: (value) => top = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Topic",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Class : ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          DropdownButton<int>(
                            value: cls,
                            hint: const Text('Select class'),
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
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Select Material : ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("SIGN UP");
                              filepicker();
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Container(
                                width: 180,
                                height: 67.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: cc,
                                ),
                                child: Center(
                                  child: Text(
                                    qxx,
                                    style: const TextStyle(
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Select Deadline : ",
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
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Container(
                                width: 180,
                                height: 77.5,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: const Color.fromRGBO(117, 123, 255, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    ff,
                                    style: const TextStyle(
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
                    ],
                  ),
                ),
                context),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  //refresh()
                  adds(),
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Assignment",
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
                        Icons.add,
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

class deciderrr extends StatefulWidget {
  const deciderrr({super.key});

  @override
  State<deciderrr> createState() => _deciderrrState();
}

class _deciderrrState extends State<deciderrr> {
  String role = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gett();
  }

  void gett() async {
    GetUserNamee gn = GetUserNamee();
    role = (await gn.getRole())!;
    if (role != "") {
      setState(() {
        role = role;
      });
    }
  }

  void adds() async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    final db = FirebaseFirestore.instance;
    if (fnxx != null) {
      var ass = {
        "Subject": top,
        "Topic": desc,
        "assign": DateTime.now(),
        "class": "$cls"
      };
      db.collection(fnxx).add(ass).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
      showsuccess();
    }
  }

  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Assignment Added',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  int? cls;
  String? top;
  String? desc;

  @override
  Widget build(BuildContext context) {
    if (role == "principal") {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              FadeAnimation3(
                  1.6,
                  Container(
                    width: 500,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(-6, -6),
                            color: Colors.white,
                            blurRadius: 8,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: const Text(
                                "Title : ",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xFFBDBDBD),
                                )),
                              ),
                              child: TextField(
                                onChanged: (value) => top = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Subject ",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: const Text(
                                "Description : ",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xFFBDBDBD),
                                )),
                              ),
                              child: TextField(
                                onChanged: (value) => desc = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "desc",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: const Text(
                                "Class : ",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            DropdownButton<int>(
                              value: cls,
                              hint: const Text('Select class'),
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
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  context),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => {
                    //refresh()
                    adds(),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Notice",
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
                          Icons.add,
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
    } else {
      return const Addass();
    }
  }
}

// ignore: must_be_immutable
class EditAss extends StatefulWidget {
  String? subject, topic;
  EditAss({super.key, required this.subject, required this.topic});

  @override
  State<EditAss> createState() => _EditAssState();
}

class _EditAssState extends State<EditAss> {
  String? sub;
  String? top;
  int? cls;
  DateTime? aa;
  DateTime? dd;
  String? urr;

  Color cc = const Color.fromRGBO(117, 123, 255, 1);

  Future<String?> uploadpdf(String fn, File file) async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    if (fnxx != null) {
      final refer = FirebaseStorage.instance
          .ref("Assignments/$fnxx/$cls/$top/Materials/$fn.pdf");

      final uploadTask = refer.putFile(file);

      await uploadTask.whenComplete(() => {});

      final downlink = await refer.getDownloadURL();

      setState(() {
        cc = const Color.fromRGBO(80, 80, 80, 0.8);

        qxx = "Choosed $fn";
      });

      return downlink;
    }
    return null;
  }

  void filepicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File("${result.files.single.path}");

      String fn = result.files[0].name;

      final fownload = await uploadpdf(fn, file);

      urr = "$fownload";

      await FirebaseFirestore.instance
          .collection("Materials")
          .add({"link": fownload, "name": fn, "topic": "$top"});
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

  String qxx = "Choose File";
  String ff = "Change Date";

  void showdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color.fromRGBO(109, 116, 255, 1),
              colorScheme:
                  const ColorScheme.light(primary: Color.fromRGBO(109, 116, 255, 1)),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    ).then((value) {
      setState(() {
        dd = value;
        if (dd != null) ff = "${dd!.year}/${dd!.month}/${dd!.day}";
      });
    });
  }

  // void edits() async {
  //   Getname gn = Getname();
  //   var fnxx = await gn.getRolefirst();
  //   final db = FirebaseFirestore.instance;
  //   if (fnxx != null) {
  //     var ass = {
  //       "Deadline": dd,
  //       "url": urr,
  //     };
  //     db.collection("$fnxx").add(ass).then((DocumentReference doc) =>
  //         print('DocumentSnapshot added with ID: ${doc.id}'));
  //     showsuccess();
  //   }
  // }
  void edits() async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    final db = FirebaseFirestore.instance;
    if (fnxx != null) {
      var querySnapshot = await db
          .collection(fnxx)
          .where("Subject",
              isEqualTo: widget
                  .subject) // Match the "Subject" field with the provided subject.
          .where("Topic",
              isEqualTo: widget
                  .topic) // Match the "topic" field with the provided topic.
          .get();

      // Check if any matching documents are found.
      if (querySnapshot.docs.isNotEmpty) {
        var documentId = querySnapshot.docs.first.id;
        // Update the "Deadline" and "url" fields of the matched document.
        await db.collection(fnxx).doc(documentId).update({
          "Deadline": dd,
          "url": urr,
        });

        showsuccess();
      } else {
        // Handle the case when no matching document is found.
        print("No matching document found for the provided subject and topic.");
      }
    }
  }

    void delete() async {
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    final db = FirebaseFirestore.instance;
    if (fnxx != null) {
      var querySnapshot = await db
          .collection(fnxx)
          .where("Subject",
              isEqualTo: widget
                  .subject) // Match the "Subject" field with the provided subject.
          .where("Topic",
              isEqualTo: widget
                  .topic) // Match the "topic" field with the provided topic.
          .get();

      // Check if any matching documents are found.
      if (querySnapshot.docs.isNotEmpty) {
        var documentId = querySnapshot.docs.first.id;
        // Update the "Deadline" and "url" fields of the matched document.
        await db.collection(fnxx).doc(documentId).delete();

        showsuccess3();
         Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const tasks())));
      } else {
        // Handle the case when no matching document is found.
        print("No matching document found for the provided subject and topic.");
      }
    }
  }

  void showsuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Assignment Edited',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  void showsuccess3() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                ' ✅ Assignment Deleted',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Editing ${widget.subject}"),
        backgroundColor: const Color.fromRGBO(109, 116, 255, 1),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            FadeAnimation3(
                1.6,
                Container(
                  width: 500,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-6, -6),
                          color: Colors.white,
                          blurRadius: 8,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       child: Text(
                      //         "Subject : ",
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 200,
                      //       padding: const EdgeInsets.all(4.0),
                      //       decoration: const BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //           color: Color(0xFFBDBDBD),
                      //         )),
                      //       ),
                      //       child: TextField(
                      //         onChanged: (value) => sub = value,
                      //         decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           hintText: "Subject ",
                      //           hintStyle: TextStyle(
                      //             color: Colors.grey[400],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       child: Text(
                      //         "Topic : ",
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 200,
                      //       padding: const EdgeInsets.all(4.0),
                      //       decoration: const BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //           color: Color(0xFFBDBDBD),
                      //         )),
                      //       ),
                      //       child: TextField(
                      //         onChanged: (value) => top = value,
                      //         decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           hintText: "Topic",
                      //           hintStyle: TextStyle(
                      //             color: Colors.grey[400],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       child: Text(
                      //         "Class : ",
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //         ),
                      //       ),
                      //     ),
                      //     DropdownButton<int>(
                      //       value: cls,
                      //       hint: Text('Select class'),
                      //       items: List.generate(10, (index) {
                      //         return DropdownMenuItem<int>(
                      //           value: index + 1,
                      //           child: Text((index + 1).toString()),
                      //         );
                      //       }),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           cls = value;
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Change Material : ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("SIGN UP");
                              filepicker();
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Container(
                                width: 180,
                                height: 67.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: cc,
                                ),
                                child: Center(
                                  child: Text(
                                    qxx,
                                    style: const TextStyle(
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              "Change Deadline : ",
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
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Container(
                                width: 180,
                                height: 77.5,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: const Color.fromRGBO(117, 123, 255, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    ff,
                                    style: const TextStyle(
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
                    ],
                  ),
                ),
                context),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  //refresh()
                  edits(),
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Row(
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
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () => {
                  //refresh()
                  delete(),
                  print("object")
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remove Assignment",
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
                        Icons.delete,
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
