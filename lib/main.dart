import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsy_trials/views/pages/00_splash/splash_screen.dart';
import 'package:tipsy_trials/views/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    title: 'Tipsy Trials',
    theme: AppThemes.lightTheme,
    home: SplashScreen(), // Replace AppRoot() with SplashScreen()
    enableLog: true,
    debugShowCheckedModeBanner: false,
  ));
}
