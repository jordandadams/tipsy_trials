import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

import '../models/lobby.dart';

class JoinController extends GetxController {
  final usernames = <String>[].obs;

  String? username;

  void addUser(String username) {
    if (username.isNotEmpty) {
      usernames.add(username);
      this.username = username;
    }
  }

  void setInitialUsername(String username) {
    if (usernames.isEmpty) {
      addUser(username);
    }
  }
}
