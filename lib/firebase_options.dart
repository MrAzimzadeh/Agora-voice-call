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
    apiKey: 'AIzaSyD0VScQ87L8yGySR3iLwrF0vhNF0E-bsS4',
    appId: '1:96880764953:web:1cec61e0568462aef4e288',
    messagingSenderId: '96880764953',
    projectId: 'voice-call-d4ef5',
    authDomain: 'voice-call-d4ef5.firebaseapp.com',
    storageBucket: 'voice-call-d4ef5.appspot.com',
    measurementId: 'G-R1BT592JTQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRgM4nss3f4HRSyR0Id2Y8_XUZlTkjKiI',
    appId: '1:96880764953:android:80bb9f164366985ff4e288',
    messagingSenderId: '96880764953',
    projectId: 'voice-call-d4ef5',
    storageBucket: 'voice-call-d4ef5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBg6w9s14Kz-pUHa9QxjBG37rVgStw9xsA',
    appId: '1:96880764953:ios:03613c129cd12154f4e288',
    messagingSenderId: '96880764953',
    projectId: 'voice-call-d4ef5',
    storageBucket: 'voice-call-d4ef5.appspot.com',
    iosBundleId: 'com.azimzada.voicecallexample.voiceCallExample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBg6w9s14Kz-pUHa9QxjBG37rVgStw9xsA',
    appId: '1:96880764953:ios:03613c129cd12154f4e288',
    messagingSenderId: '96880764953',
    projectId: 'voice-call-d4ef5',
    storageBucket: 'voice-call-d4ef5.appspot.com',
    iosBundleId: 'com.azimzada.voicecallexample.voiceCallExample',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0VScQ87L8yGySR3iLwrF0vhNF0E-bsS4',
    appId: '1:96880764953:web:ee1e94eb307dc817f4e288',
    messagingSenderId: '96880764953',
    projectId: 'voice-call-d4ef5',
    authDomain: 'voice-call-d4ef5.firebaseapp.com',
    storageBucket: 'voice-call-d4ef5.appspot.com',
    measurementId: 'G-WDTQGSMZ71',
  );
}
