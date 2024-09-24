// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDJ3vaRth6ziL2vuYapdyNS_AdpofqjW4Q',
    appId: '1:477534044858:web:c6dfe4a6cbcccd88aeb883',
    messagingSenderId: '477534044858',
    projectId: 'course-motobike-3d695',
    authDomain: 'course-motobike-3d695.firebaseapp.com',
    storageBucket: 'course-motobike-3d695.appspot.com',
    measurementId: 'G-VDW3TXXE00',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLYTzBNna0rv_7LzOg4Yo5FmiEe4sPzBo',
    appId: '1:477534044858:android:a5434dc1be5cc637aeb883',
    messagingSenderId: '477534044858',
    projectId: 'course-motobike-3d695',
    storageBucket: 'course-motobike-3d695.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3-GU3qFV39ZPGQF_pnBzPjFu7kjb-49M',
    appId: '1:477534044858:ios:e898eaf96dbd5f77aeb883',
    messagingSenderId: '477534044858',
    projectId: 'course-motobike-3d695',
    storageBucket: 'course-motobike-3d695.appspot.com',
    iosBundleId: 'com.example.flutterMotobikeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3-GU3qFV39ZPGQF_pnBzPjFu7kjb-49M',
    appId: '1:477534044858:ios:e898eaf96dbd5f77aeb883',
    messagingSenderId: '477534044858',
    projectId: 'course-motobike-3d695',
    storageBucket: 'course-motobike-3d695.appspot.com',
    iosBundleId: 'com.example.flutterMotobikeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDJ3vaRth6ziL2vuYapdyNS_AdpofqjW4Q',
    appId: '1:477534044858:web:314cef7bd864ed1caeb883',
    messagingSenderId: '477534044858',
    projectId: 'course-motobike-3d695',
    authDomain: 'course-motobike-3d695.firebaseapp.com',
    storageBucket: 'course-motobike-3d695.appspot.com',
    measurementId: 'G-NGQCSS38PR',
  );

}