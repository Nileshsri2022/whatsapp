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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB4b2d3WGNVjp0K1VILsbpmWUY3wsl1gAQ',
    appId: '1:511451223255:web:2b3bd48bb11154da328c92',
    messagingSenderId: '511451223255',
    projectId: 'whatsapp-b5795',
    authDomain: 'whatsapp-b5795.firebaseapp.com',
    storageBucket: 'whatsapp-b5795.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjgrko8XVbnaswtaZTrAMmLTQ3CshNSKQ',
    appId: '1:511451223255:android:974c743c145447ec328c92',
    messagingSenderId: '511451223255',
    projectId: 'whatsapp-b5795',
    storageBucket: 'whatsapp-b5795.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_yEj74SBTuQJwB9GWSmLRtWRUwgOXufk',
    appId: '1:511451223255:ios:34a2cfabdccc64d2328c92',
    messagingSenderId: '511451223255',
    projectId: 'whatsapp-b5795',
    storageBucket: 'whatsapp-b5795.appspot.com',
    iosBundleId: 'com.example.whatsappUi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYuzijha4BUBufe_KEWrh1eHQinIiNKiM',
    appId: '1:693857432619:web:93c99368bae134ac84e66e',
    messagingSenderId: '693857432619',
    projectId: 'whatsapp-78c53',
    authDomain: 'whatsapp-78c53.firebaseapp.com',
    storageBucket: 'whatsapp-78c53.appspot.com',
  );

}