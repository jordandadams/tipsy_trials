import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import 'dart:async';

class LocalPlayController extends GetxController {
  final usernames = <String>[].obs;

  final showInputField = false.obs;

  Timer? _usernameValidationTimer;

  var usernameInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ).obs;

  final usernameFocusNode = FocusNode();

  var errorMessage = ''.obs;

  final TextEditingController usernameController = TextEditingController();

  final canProceed = false.obs; // Add the new observable variable

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(validateForm);
  }

  @override
  void onClose() {
    usernameController.removeListener(validateForm);
    super.onClose();
  }

  void addUser(String username) {
    if (username.isNotEmpty) {
      usernames.add(username);
    }
  }

  void toggleInputField() {
    showInputField.value = !showInputField.value;
  }

  void addPlayer(String username) {
    addUser(username);
    toggleInputField();
    usernameController.clear();
  }

  BorderSide focusedBorderSide() {
    return BorderSide(color: AppColors.primaryColor);
  }

  BorderSide defaultBorderSide() {
    return BorderSide(color: Colors.grey);
  }

  void validateForm() {
    String? error = _usernameValidator(usernameController.text);
    if (error != null) {
      errorMessage.value = error;
    } else {
      errorMessage.value = '';
    }
    _updateCanProceed();
  }

  String? _usernameValidator(String value) {
    if (_usernameValidationTimer != null) {
      _usernameValidationTimer!.cancel();
    }

    _usernameValidationTimer = Timer(Duration(seconds: 1), () {
      if (value.isEmpty) {
        errorMessage.value = 'Username is required';
      } else if (value.length < 4 || value.length > 15) {
        errorMessage.value = 'Username must be between 4 and 15 characters';
      } else if (value.contains(RegExp(r'\d')) && int.tryParse(value) != null) {
        errorMessage.value = 'Username cannot contain only numbers';
      } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        errorMessage.value = 'Username cannot contain special characters';
      } else if (usernames.contains(value)) {
        errorMessage.value = "Username cannot match another players name!";
      } else {
        errorMessage.value = '';
      }
    });

    return null;
  }

  void _updateCanProceed() {
    canProceed.value = _canProceed();
  }

  bool _canProceed() {
    final username = usernameController.text;
    if (username.isEmpty ||
        username.length < 4 ||
        username.length > 15 ||
        username.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        usernames.contains(username) ||
        usernames.length >= 12) {
      // Check if the list already has 12 players
      return false;
    }
    return true;
  }
}
