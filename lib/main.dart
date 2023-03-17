import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsy_trials/views/root.dart';
import 'package:tipsy_trials/views/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line before runApp()
  runApp(GetMaterialApp(
    title: 'Tipsy Trials',
    theme: AppThemes.lightTheme,
    home: AppRoot(),
    enableLog: true,
    debugShowCheckedModeBanner: false,
  ));
}
