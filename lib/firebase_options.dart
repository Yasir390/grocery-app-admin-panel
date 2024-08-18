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
    apiKey: 'AIzaSyAiXTJLGgsyEYBzfdTIXLPz3KT5kk557EA',
    appId: '1:635309356149:web:500dee30299589f124f43c',
    messagingSenderId: '635309356149',
    projectId: 'grocery-app-project-new',
    authDomain: 'grocery-app-project-new.firebaseapp.com',
    storageBucket: 'grocery-app-project-new.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2DupgJmrvkn18qHkD5AG7QBEKxytNw0E',
    appId: '1:635309356149:android:ba00877ec3f6889a24f43c',
    messagingSenderId: '635309356149',
    projectId: 'grocery-app-project-new',
    storageBucket: 'grocery-app-project-new.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJzdyhBUrJ75JmW33Pv9SkXRgGhvW3Yjs',
    appId: '1:635309356149:ios:4ebb10977f532fe624f43c',
    messagingSenderId: '635309356149',
    projectId: 'grocery-app-project-new',
    storageBucket: 'grocery-app-project-new.appspot.com',
    androidClientId: '635309356149-8kscm3351tkb8i7gtbivenvb64pcn167.apps.googleusercontent.com',
    iosClientId: '635309356149-28qlb6tle83kqjlq8os42e6c1ogq9puq.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminGroceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJzdyhBUrJ75JmW33Pv9SkXRgGhvW3Yjs',
    appId: '1:635309356149:ios:4ebb10977f532fe624f43c',
    messagingSenderId: '635309356149',
    projectId: 'grocery-app-project-new',
    storageBucket: 'grocery-app-project-new.appspot.com',
    androidClientId: '635309356149-8kscm3351tkb8i7gtbivenvb64pcn167.apps.googleusercontent.com',
    iosClientId: '635309356149-28qlb6tle83kqjlq8os42e6c1ogq9puq.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminGroceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAiXTJLGgsyEYBzfdTIXLPz3KT5kk557EA',
    appId: '1:635309356149:web:949754fc07fe59b024f43c',
    messagingSenderId: '635309356149',
    projectId: 'grocery-app-project-new',
    authDomain: 'grocery-app-project-new.firebaseapp.com',
    storageBucket: 'grocery-app-project-new.appspot.com',
  );
}
