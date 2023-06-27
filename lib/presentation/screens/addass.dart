import 'package:edusphere/data/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  Color cc = Color.fromRGBO(113, 73, 198, 0.8);

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
        cc = Color.fromRGBO(80, 80, 80, 0.8);

        qxx = "Choosed $fn";
      });

      return downlink;
    }
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
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        dd = value;
        if (dd != null) ff = dd.toString().trim();
      });
    });
  }

  void adds() async{
    Getname gn = Getname();
    var fnxx = await gn.getRolefirst();
    final db = FirebaseFirestore.instance;
    if (fnxx != null) {
      var ass = {
        "Subject": sub,
        "Topic": top,
        "assign": DateTime.now(),
        "Deadline": dd,
        "url": urr,
        "class": "$cls"
      };
      db.collection("$fnxx").add(ass).then((DocumentReference doc) =>
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
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 500,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
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
                        child: Text(
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
                        child: Text(
                          "Class : ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      DropdownButton<int>(
                        value: cls,
                        hint: Text('Select your class'),
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
                        child: Text(
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
                                offset: Offset(0, 3),
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
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: cc,
                            ),
                            child: Center(
                              child: Text(
                                "$qxx",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
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
                              color: Color.fromRGBO(113, 73, 198, 0.8),
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
                ],
              ),
            ),
            SizedBox(
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Row(
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
