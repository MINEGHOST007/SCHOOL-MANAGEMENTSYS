// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCGiN28UL2sth-kNIuuaTJKSm_QX-3qxE4',
    appId: '1:244466310354:web:74468fc5495f18e200a10b',
    messagingSenderId: '244466310354',
    projectId: 'edushpere',
    authDomain: 'edushpere.firebaseapp.com',
    storageBucket: 'edushpere.appspot.com',
    measurementId: 'G-RDW41S04G4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-ptdAUnguoqmNnep7YvoA_9iMgZSJNf8',
    appId: '1:244466310354:android:03899cc46af05d0d00a10b',
    messagingSenderId: '244466310354',
    projectId: 'edushpere',
    storageBucket: 'edushpere.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClbfRHYjad2u2ypXNp-7yLruSiGL2Lcao',
    appId: '1:244466310354:ios:6f92192597b1067100a10b',
    messagingSenderId: '244466310354',
    projectId: 'edushpere',
    storageBucket: 'edushpere.appspot.com',
    iosClientId: '244466310354-eb20l3nes98lo9feq76m3e8857phia2t.apps.googleusercontent.com',
    iosBundleId: 'com.example.edusphere',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClbfRHYjad2u2ypXNp-7yLruSiGL2Lcao',
    appId: '1:244466310354:ios:6f92192597b1067100a10b',
    messagingSenderId: '244466310354',
    projectId: 'edushpere',
    storageBucket: 'edushpere.appspot.com',
    iosClientId: '244466310354-eb20l3nes98lo9feq76m3e8857phia2t.apps.googleusercontent.com',
    iosBundleId: 'com.example.edusphere',
  );
}
