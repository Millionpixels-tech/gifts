// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env["FIREBASE_WEB_API_KEY"]!,
    appId: '1:489835318094:web:1f71fd16643ad304b7ac1f',
    messagingSenderId: '489835318094',
    projectId: 'boxes-8c013',
    authDomain: 'boxes-8c013.firebaseapp.com',
    databaseURL: 'https://boxes-8c013-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'boxes-8c013.appspot.com',
    measurementId: 'G-0ELPRG1RKP',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env["FIREBASE_ANDROID_API_KEY"]!,
    appId: '1:489835318094:android:d63fec2b9ecda67fb7ac1f',
    messagingSenderId: '489835318094',
    projectId: 'boxes-8c013',
    databaseURL: 'https://boxes-8c013-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'boxes-8c013.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env["FIREBASE_IOS_API_KEY"]!,
    appId: '1:489835318094:ios:a3f08f03231f116cb7ac1f',
    messagingSenderId: '489835318094',
    projectId: 'boxes-8c013',
    databaseURL: 'https://boxes-8c013-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'boxes-8c013.appspot.com',
    iosBundleId: 'com.millionpixels.gifts',
  );
}
