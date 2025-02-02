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
      apiKey: "AIzaSyAV4I1p8YAur-Ijrcp1-07XA8niWFNg8cA",
      authDomain: "mydashboard-8e6c4.firebaseapp.com",
      projectId: "mydashboard-8e6c4",
      storageBucket: "mydashboard-8e6c4.appspot.com",
      messagingSenderId: "916994586971",
      appId: "1:916994586971:web:7a2fd1c6f190c43fb2027e",
      measurementId: "G-5R72TC4FVR"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX99RXjrjQ1aOb_xT1ve4NswNM3jz769E',
    appId: '1:916994586971:android:2c24b826ce8dc326b2027e',
    messagingSenderId: '916994586971',
    projectId: 'mydashboard-8e6c4',
    storageBucket: 'mydashboard-8e6c4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdDqAy3qs98yHBHGSbm7j9Z8AIimHJIiE',
    appId: '1:916994586971:ios:2502d51cbbd1282eb2027e',
    messagingSenderId: '916994586971',
    projectId: 'mydashboard-8e6c4',
    storageBucket: 'mydashboard-8e6c4.appspot.com',
    iosBundleId: 'com.example.efreigrp2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdDqAy3qs98yHBHGSbm7j9Z8AIimHJIiE',
    appId: '1:916994586971:ios:cd85e86d09298dc5b2027e',
    messagingSenderId: '916994586971',
    projectId: 'mydashboard-8e6c4',
    storageBucket: 'mydashboard-8e6c4.appspot.com',
    iosBundleId: 'com.example.efreigrp2.RunnerTests',
  );
}
