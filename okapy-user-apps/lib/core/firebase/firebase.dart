import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:okapy/core/firebase/firebase_options.dart';

Future initialiseFirebase() async {
  // if (kReleaseMode) {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // } else {
  //   return false;
  // }
}
