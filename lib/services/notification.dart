import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundmsg(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Payload: ${message.data}');
}

Future<String?> getFcm() async {
  String? fcm = await FirebaseMessaging.instance.getToken();
  return fcm;
}

class FirebaseApi {
  final _firebasemessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebasemessaging.requestPermission();
    final fcmT = await getFcm();
    print('Token : $fcmT');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundmsg);
  }
}
