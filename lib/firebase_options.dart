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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-IDkPk1QOJnu5AjceYsPvPDd73eJhLV4',
    appId: '1:1063163179126:web:cfe53e19f7664aaaacef57',
    messagingSenderId: '1063163179126',
    projectId: 'farm-management-91b4c',
    authDomain: 'farm-management-91b4c.firebaseapp.com',
    storageBucket: 'farm-management-91b4c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAomaW5NgRN7CTGLMoU173cq4Xa6ZYe2GU',
    appId: '1:1063163179126:android:311b2afc6a432c2aacef57',
    messagingSenderId: '1063163179126',
    projectId: 'farm-management-91b4c',
    storageBucket: 'farm-management-91b4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByGrrtN5763bkmjQabjDTVDHCRkJmhrpM',
    appId: '1:1063163179126:ios:5ee038e5dc7a49dcacef57',
    messagingSenderId: '1063163179126',
    projectId: 'farm-management-91b4c',
    storageBucket: 'farm-management-91b4c.appspot.com',
    iosClientId: '1063163179126-e8e0jsitp594ganr0n69qpt8hi044mvp.apps.googleusercontent.com',
    iosBundleId: 'com.example.farmManagementProj',
  );
}
