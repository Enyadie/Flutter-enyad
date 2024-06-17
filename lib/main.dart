import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/repositories/authentication/authen_repository.dart';
import 'features/personalization/controller/user_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  ///---widget binding---
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  ///---local storage GetXStorage---
  await GetStorage.init();

  ///--- await native splash ---
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///---int firebase---
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  Get.put(UserController());

  runApp(const App());
}
