import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import 'dart:async';

class MultiplayerController extends GetxController {
  final usernames = <String>[].obs;

  void addUser(String username) {
    if (username.isNotEmpty) {
      usernames.add(username);
    }
  }

  void setInitialUsername(String username) {
    if (usernames.isEmpty) {
      addUser(username);
    }
  }
}
