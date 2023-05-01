import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/aitebar_web.dart';
import 'package:aitebar/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// dependency injection
  configureDependencies();
  debugPrint('main: runApp');
  runApp(const AitebarWeb());
}
