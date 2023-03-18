import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/local_play_controller.dart';

class AddUserField extends StatelessWidget {
  final Function(String) onChanged;

  AddUserField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final LocalPlayController localPlayController = Get.find();
    return TextField(
      focusNode: localPlayController.usernameFocusNode,
      controller: localPlayController.usernameController,
      onChanged: (value) => onChanged(value), // Update this line
      decoration: InputDecoration(
        hintText: 'Enter a username...',
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: localPlayController.focusedBorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: localPlayController.defaultBorderSide(),
        ),
      ),
    );
  }
}
