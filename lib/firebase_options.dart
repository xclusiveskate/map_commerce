// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

import 'package:firebase_core/firebase_core.dart';
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
    apiKey: 'AIzaSyDLSO1XNVbFcPZfg1_0ZkE_S3IOiyonxsE',
    appId: '1:452089550029:web:bf7873aaac01c1fe944584',
    messagingSenderId: '452089550029',
    projectId: 'map-commerce-edc3b',
    authDomain: 'map-commerce-edc3b.firebaseapp.com',
    storageBucket: 'map-commerce-edc3b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9dVpnThyy4yLbq5nG8ODA9HK4pr2XrMk',
    appId: '1:452089550029:android:9846acb0d336d9e0944584',
    messagingSenderId: '452089550029',
    projectId: 'map-commerce-edc3b',
    storageBucket: 'map-commerce-edc3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDne877IIzwFhAHHNDEd4Mb1sN4FYhy7Mk',
    appId: '1:452089550029:ios:a69b90b3141d971a944584',
    messagingSenderId: '452089550029',
    projectId: 'map-commerce-edc3b',
    storageBucket: 'map-commerce-edc3b.appspot.com',
    iosBundleId: 'com.example.mapCommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDne877IIzwFhAHHNDEd4Mb1sN4FYhy7Mk',
    appId: '1:452089550029:ios:d33b1df03a60da64944584',
    messagingSenderId: '452089550029',
    projectId: 'map-commerce-edc3b',
    storageBucket: 'map-commerce-edc3b.appspot.com',
    iosBundleId: 'com.example.mapCommerce.RunnerTests',
  );
}
