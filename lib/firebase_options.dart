// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA-silanLbIXbEFcgbjOtzTo-p2zJSnXpo',
    appId: '1:750508487091:web:638c7a44a4d788fbc3dbc6',
    messagingSenderId: '750508487091',
    projectId: 'projetofinalginasio',
    authDomain: 'projetofinalginasio.firebaseapp.com',
    storageBucket: 'projetofinalginasio.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2RzVWfooP7b5J3Zlu0kXHT3LgZXKxhcs',
    appId: '1:750508487091:android:da7dedff529d2a99c3dbc6',
    messagingSenderId: '750508487091',
    projectId: 'projetofinalginasio',
    storageBucket: 'projetofinalginasio.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaDRpsoZ9DdhFpjp0hb_KfeWf_ywg-E90',
    appId: '1:750508487091:ios:aa7eb0901e34e8ddc3dbc6',
    messagingSenderId: '750508487091',
    projectId: 'projetofinalginasio',
    storageBucket: 'projetofinalginasio.firebasestorage.app',
    iosBundleId: 'com.example.trabalhoFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaDRpsoZ9DdhFpjp0hb_KfeWf_ywg-E90',
    appId: '1:750508487091:ios:aa7eb0901e34e8ddc3dbc6',
    messagingSenderId: '750508487091',
    projectId: 'projetofinalginasio',
    storageBucket: 'projetofinalginasio.firebasestorage.app',
    iosBundleId: 'com.example.trabalhoFinal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-silanLbIXbEFcgbjOtzTo-p2zJSnXpo',
    appId: '1:750508487091:web:058d9e9181877254c3dbc6',
    messagingSenderId: '750508487091',
    projectId: 'projetofinalginasio',
    authDomain: 'projetofinalginasio.firebaseapp.com',
    storageBucket: 'projetofinalginasio.firebasestorage.app',
  );
}