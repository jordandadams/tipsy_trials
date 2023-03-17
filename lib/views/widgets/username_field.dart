import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class UsernameField extends StatefulWidget {
  const UsernameField({Key? key}) : super(key: key);

  @override
  _UsernameFieldState createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    homeController.usernameFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    homeController.usernameFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (homeController.usernameFocusNode.hasFocus) {
      homeController.setUsernameInputBorder(
        OutlineInputBorder(borderSide: homeController.focusedBorderSide()),
      );
    } else {
      homeController.setUsernameInputBorder(
        OutlineInputBorder(borderSide: homeController.defaultBorderSide()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        focusNode: homeController.usernameFocusNode,
        decoration: InputDecoration(
          labelText: 'Enter your username...',
          border: OutlineInputBorder(),
          enabledBorder: homeController.usernameInputBorder.value,
          focusedBorder: homeController.usernameInputBorder.value,
        ),
      ),
    );
  }
}