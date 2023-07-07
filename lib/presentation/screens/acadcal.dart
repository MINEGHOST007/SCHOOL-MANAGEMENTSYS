import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusphere/data/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:table_calendar/table_calendar.dart';

class acadcalender extends StatefulWidget {
  const acadcalender({super.key});

  @override
  State<acadcalender> createState() => _acadcalenderState();
}

class _acadcalenderState extends State<acadcalender> {
  CalendarFormat _calenderf = CalendarFormat.month;
  DateTime focusday = DateTime.now();
  DateTime? selected;
  String? role;
  final tc = TextEditingController();
  final dc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = focusday;
    getacc();
  }

  void getacc() async {
    GetUserNamee hn = GetUserNamee();
    role = await hn.getRole();
    if (role != null) {
      setState(() {
        role = role;
      });
    }
  }

  showaddevent() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "Add New Event",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tc,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: dc,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      if (tc.text.isEmpty && dc.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Required title and description'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      } else {
                        final selectedDate = selected!;
                        final eventDocId =
                            '${selectedDate.year.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                        await FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventDocId)
                            .set({
                          'title': tc.text,
                          'description': dc.text,
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Event')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (role == "teacher") {
      return Scaffold(
        backgroundColor: const Color.fromARGB(176, 196, 195, 195),
        body: Stack(
          children: [
            AppBar(
              leading: Container(),
              elevation: 0,
              toolbarHeight: 160,
              backgroundColor: const Color.fromARGB(176, 196, 195, 195),
              flexibleSpace: Container(
                width: 500,
                height: 220,
                padding: const EdgeInsets.only(top: 80, left: 25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(104, 112, 255, 1),
                      Color.fromRGBO(114, 120, 243, 0.6),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 120,
                child: Container(
                  margin: const EdgeInsets.all(30),
                  width: 350,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2050),
                    focusedDay: focusday,
                    calendarFormat: _calenderf,
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(selected, selectedDay)) {
                        setState(() {
                          selected = selectedDay;
                          focusday = focusedDay;
                        });
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(selected, day);
                    },
                    onFormatChanged: (format) {
                      if (_calenderf != format) {
                        setState(() {
                          _calenderf = format;
                        });
                      }
                    },
                  ),
                )),
            Positioned(
              bottom: 48.0,
              right: 16.0,
              child: FloatingActionButton.extended(
                onPressed: showaddevent,
                label: const Text('Add Event'),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 30,
              child: SingleChildScrollView(
                child: Container(
                  width: 350,
                  height: 100,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('events')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print("hhhhhhhhhhhhhhhh");
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
              
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
              
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        print(
                            '${selected!.year.toString().padLeft(2, '0')}-${selected!.month.toString().padLeft(2, '0')}-${selected!.day.toString().padLeft(2, '0')}');
                        print("object");
                        print("xxxxxxxxxxxxxxxx");
                        return const Center(
                          child: Text('No events found for the selected date.'),
                        );
                      }
                      print("xxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyy");
                      
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                        ),
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var event = snapshot.data!.docs[index];
                            var title = event['title'];
                            var description = event['description'];
                            print(event.id);
                            print(
                                '${selected!.year.toString().padLeft(2, '0')}-${selected!.month.toString().padLeft(2, '0')}-${selected!.day.toString().padLeft(2, '0')}');
                            if (event.id ==
                                '${selected!.year.toString().padLeft(2, '0')}-${selected!.month.toString().padLeft(2, '0')}-${selected!.day.toString().padLeft(2, '0')}') {
                              return ListTile(
                                title: Text(title,
                            style: const TextStyle(
                              fontFamily: 'Poppins'
                            ),),
                                subtitle: Text(description),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(176, 196, 195, 195),
        body: Stack(
          children: [
            AppBar(
              leading: Container(),
              elevation: 0,
              toolbarHeight: 160,
              backgroundColor: const Color.fromARGB(176, 196, 195, 195),
              flexibleSpace: Container(
                width: 500,
                height: 220,
                padding: const EdgeInsets.only(top: 80, left: 25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(104, 112, 255, 1),
                      Color.fromRGBO(114, 120, 243, 0.6),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 120,
                child: Container(
                  margin: const EdgeInsets.all(30),
                  width: 350,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2050),
                    focusedDay: focusday,
                    calendarFormat: _calenderf,
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(selected, selectedDay)) {
                        setState(() {
                          selected = selectedDay;
                          focusday = focusedDay;
                        });
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(selected, day);
                    },
                    onFormatChanged: (format) {
                      if (_calenderf != format) {
                        setState(() {
                          _calenderf = format;
                        });
                      }
                    },
                  ),
                )),
            Positioned(
              bottom: 48,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("hhhhhhhhhhhhhhhh");
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    print("xxxxxxxxxxxxxxxx");
                    return const Center(
                      child: Text('No events found for the selected date.'),
                    );
                  }
                  print("xxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyy");
                  return Container(
                    width: 300,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                      ),
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var event = snapshot.data!.docs[index];
                        var title = event['title'];
                        var description = event['description'];
                        if (event.id ==
                                '${selected!.year.toString().padLeft(2, '0')}-${selected!.month.toString().padLeft(2, '0')}-${selected!.day.toString().padLeft(2, '0')}') {
                          return ListTile(
                          title: Text(title,
                          style: const TextStyle(
                            fontFamily: 'Poppins'
                          ),
                          ),
                          subtitle: Text(description),
                        );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
