import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  CalendarFormat _calenderf = CalendarFormat.month;
  DateTime focusday = DateTime.now();
  DateTime? selected;
  String? role;
  DocumentSnapshot? attendance;
  Map<String, dynamic>? data;
  void getatt() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Attendance');
    print("zzzzzzzzzzzz");
    DocumentSnapshot snapshot = await users.doc('${user!.email}').get();
    if (snapshot != null) {
      attendance = snapshot;
      print(attendance!['2023-06-30']);
      setState(() {
        attendance = attendance;
        data = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  Color determineDotColor(bool attendanceValue) {
    return attendanceValue ? Colors.green : Colors.red;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getatt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Container(
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
              // eventLoader: (date) {
              //   return _attendanceData[date] != null ? [_attendanceData[date]] : [];
              // },
              // calendarStyle: CalendarStyle(
              //   markerDecoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              // ),
              // calendarBuilders: CalendarBuilders(
              //   markerBuilder: (context, date, events) {
              //     if (events.isNotEmpty) {
              //       return Positioned(
              //         top: 3,
              //         left: 3,
              //         child: Container(
              //           width: 6,
              //           height: 6,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: _getDotColor(date),
              //           ),
              //         ),
              //       );
              //     }
              //     return const SizedBox.shrink();
              //   },
              // ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (attendance != null) {
                    print("fffffffffff");
                    String z = DateFormat('yyyy-MM-dd').format(day);
                    data = attendance!.data() as Map<String, dynamic>?;
                    if(data != null ){
                      if (data!.containsKey(z)){
                      if(attendance![z])
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(100, 140, 255, 144),
                              ),
                            ),
                          ),
                        ],
                      );
                    else
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(98, 255, 124, 124),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    
                    }
                  }
                  // return Expanded(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Color.fromARGB(100, 140, 255, 144),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
