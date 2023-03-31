import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:tipsy_trials/views/pages/02_home/home.dart';
import 'pages/01_intro/intro.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _showIntroScreens = true;

  @override
  void initState() {
    super.initState();
    _checkIntroScreensShown();
  }

  Future<void> _checkIntroScreensShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introScreensShown = prefs.getBool('intro_screens_shown') ?? false;
    if (introScreensShown) {
      setState(() {
        _showIntroScreens = false;
      });
    } else {
      await prefs.setBool('intro_screens_shown', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If the intro screens have been shown before, redirect to another screen (e.g., HomeScreen)
    // Otherwise, show the intro screens
    return _showIntroScreens ? IntroScreens() : HomeScreen(); // Replace HomeScreen() with your actual home screen
  }
}