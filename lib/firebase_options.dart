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
    apiKey: 'AIzaSyDBra_DXRwyFoEdaLbb1TMUOZrGZLpGdm8',
    appId: '1:492868721154:web:1937386b59f009cabaa51b',
    messagingSenderId: '492868721154',
    projectId: 'teastlearingapp',
    authDomain: 'teastlearingapp.firebaseapp.com',
    storageBucket: 'teastlearingapp.appspot.com',
    measurementId: 'G-TED0M1JYCT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTQd5U5ByuuQA8VPS8Ry8LPwnci_YXekI',
    appId: '1:492868721154:android:a8462c8e276fa314baa51b',
    messagingSenderId: '492868721154',
    projectId: 'teastlearingapp',
    storageBucket: 'teastlearingapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAAUdGrX5k7Eas_L3GMOBQRaAOa3TS-b0',
    appId: '1:492868721154:ios:f9aa55e9f1732236baa51b',
    messagingSenderId: '492868721154',
    projectId: 'teastlearingapp',
    storageBucket: 'teastlearingapp.appspot.com',
    iosBundleId: 'com.example.easyLearnTeacher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAAUdGrX5k7Eas_L3GMOBQRaAOa3TS-b0',
    appId: '1:492868721154:ios:f9aa55e9f1732236baa51b',
    messagingSenderId: '492868721154',
    projectId: 'teastlearingapp',
    storageBucket: 'teastlearingapp.appspot.com',
    iosBundleId: 'com.example.easyLearnTeacher',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDBra_DXRwyFoEdaLbb1TMUOZrGZLpGdm8',
    appId: '1:492868721154:web:124c308edd77f7b3baa51b',
    messagingSenderId: '492868721154',
    projectId: 'teastlearingapp',
    authDomain: 'teastlearingapp.firebaseapp.com',
    storageBucket: 'teastlearingapp.appspot.com',
    measurementId: 'G-ZFYVFWJYJB',
  );
}
