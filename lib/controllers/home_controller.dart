import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class HomeController extends GetxController {
  final selectedMode = ''.obs;
  var usernameInputBorder = InputBorder.none.obs;
  final usernameFocusNode = FocusNode();

  void setSelectedMode(String mode) {
    selectedMode.value = mode;
  }

  void setUsernameInputBorder(InputBorder border) {
    usernameInputBorder.value = border;
  }

  BorderSide focusedBorderSide() {
    return BorderSide(color: AppColors.primaryColor);
  }

  BorderSide defaultBorderSide() {
    return BorderSide(color: Colors.grey);
  }
}
