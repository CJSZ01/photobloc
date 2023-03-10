import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbMMgWA_qFf6NyXysKaEZ4UxpRZiFbHoU',
    appId: '1:1072991004396:android:d092945f69c4e2d24727c9',
    messagingSenderId: '1072991004396',
    projectId: 'photobloc',
    storageBucket: 'photobloc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiwSolMfaCamxk4UukxQrkWDFUMqa3kcE',
    appId: '1:1072991004396:ios:3c81c50b52178f454727c9',
    messagingSenderId: '1072991004396',
    projectId: 'photobloc',
    storageBucket: 'photobloc.appspot.com',
    iosClientId:
        '1072991004396-d8opelth59kipb6o9otmnive99v0lp8r.apps.googleusercontent.com',
    iosBundleId: 'com.cjsz.photobloc',
  );
}
