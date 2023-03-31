import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import 'dart:async';

class HomeController extends GetxController {
  final selectedMode = ''.obs;

  String _mode = '';

  Timer? _usernameValidationTimer;

  var usernameInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ).obs;

  final usernameFocusNode = FocusNode();

  var errorMessage = ''.obs;

  final TextEditingController usernameController = TextEditingController();

  final isSelectedMultiplayer = false.obs;
  final isSelectedLocalPlay = false.obs;

  final canProceed = false.obs; // Add the new observable variable

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(validateForm);
  }

  @override
  void onClose() {
    usernameController.removeListener(validateForm);
    isSelectedMultiplayer.close();
    isSelectedLocalPlay.close();
    super.onClose();
  }

  void setSelectedMode(String mode) {
    print('Setting mode to: $mode'); // Debug print
    _mode = mode;
    if (mode == 'multiplayer') {
      isSelectedMultiplayer.value = true;
      isSelectedLocalPlay.value = false;
    } else if (mode == 'local') {
      isSelectedMultiplayer.value = false;
      isSelectedLocalPlay.value = true;
    }
    selectedMode.value = _mode;
    validateForm(); // Update the canProceed value
    update();
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
        username.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    if (selectedMode.value.isEmpty) {
      return false;
    }
    return true;
  }
}
