import 'package:edusphere/presentation/screens/home.dart';
import 'package:edusphere/presentation/screens/splashscreen.dart';
import 'package:edusphere/services/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   String? title = message.notification!.title;
    //   String? body = message.notification!.body;
    //   AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //         id: 123,
    //         channelKey: 'reminder',
    //         color: Colors.white,
    //         title: title,
    //         body: body,
    //         category: NotificationCategory.Alarm,
    //         wakeUpScreen: true,
    //         fullScreenIntent: true,
    //         autoDismissible: false,
    //         backgroundColor: Colors.deepPurpleAccent[400],
    //       ),
    //       actionButtons: [
    //         NotificationActionButton(
    //           key: 'Mark',
    //           label: "Mark Attendance",
    //           color: Colors.deepPurpleAccent[400],
    //           autoDismissible: true,
    //         ),
    //         NotificationActionButton(
    //           key: 'Remind',
    //           label: "Remind me later",
    //           color: Colors.black,
    //           autoDismissible: true,
    //         ),
    //       ]);
    //   AwesomeNotifications().setListeners(
    //       onActionReceivedMethod: (event) async {
    //     if (event.buttonKeyPressed == "Mark") {
    //       print("add attendance");
    //     } else if (event.buttonKeyPressed == "Remind") {
    //       print("snooze");
    //     }
    //   });
    // });

    generatetoken();


    
    // notificationServices.requestNotificationPerm();
  }

  // Future<void> setupInteractedMessage() async {
  //   print("object");
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }

  // void _handleMessage(RemoteMessage message) {
  //   print(message);
  // }

  void generatetoken() async {
    String? token = await getFcm();
    print("tokeen :");
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            print(snapshot);
            return const Splash();
          }
        },
      ),
    );
  }
}
