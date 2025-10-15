import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBK6D-r0Dii-MFxQoUiBY9082tyTHrXQF0',
    appId: '1:508474989801:web:0b1146625941156473e478',
    messagingSenderId: '508474989801',
    projectId: 'pethub-app-a0f7a',
    authDomain: 'pethub-app-a0f7a.firebaseapp.com',
    storageBucket: 'pethub-app-a0f7a.firebasestorage.app',
    measurementId: 'G-E5TWCT7TNT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK6D-r0Dii-MFxQoUiBY9082tyTHrXQF0',
    appId: '1:508474989801:android:123456789',
    messagingSenderId: '508474989801',
    projectId: 'pethub-app-a0f7a',
    storageBucket: 'pethub-app-a0f7a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBK6D-r0Dii-MFxQoUiBY9082tyTHrXQF0',
    appId: '1:508474989801:ios:123456789',
    messagingSenderId: '508474989801',
    projectId: 'pethub-app-a0f7a',
    storageBucket: 'pethub-app-a0f7a.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBK6D-r0Dii-MFxQoUiBY9082tyTHrXQF0',
    appId: '1:508474989801:macos:123456789',
    messagingSenderId: '508474989801',
    projectId: 'pethub-app-a0f7a',
    storageBucket: 'pethub-app-a0f7a.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBK6D-r0Dii-MFxQoUiBY9082tyTHrXQF0',
    appId: '1:508474989801:windows:123456789',
    messagingSenderId: '508474989801',
    projectId: 'pethub-app-a0f7a',
    storageBucket: 'pethub-app-a0f7a.firebasestorage.app',
  );
}
