import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class UsernameField extends StatelessWidget {
  final Function(String) onChanged;

  UsernameField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return TextField(
      focusNode: homeController.usernameFocusNode,
      controller: homeController.usernameController,
      onChanged: (value) => onChanged(value), // Update this line
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Enter a username...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: homeController.focusedBorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: homeController.defaultBorderSide(),
        ),
      ),
    );
  }
}