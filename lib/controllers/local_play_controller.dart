// local_play_controller.dart
import 'package:get/get.dart';

class LocalPlayController extends GetxController {
  final RxList<String> usernames = RxList<String>(); // Use RxList<String>

  void addUser(String username) {
    usernames.add(username);
  }
}