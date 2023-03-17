import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedMode = ''.obs;

  void setSelectedMode(String mode) {
    selectedMode.value = mode;
  }
}
