import 'package:get/get.dart';

class VisibleCardIndexController extends GetxController {
  var _currentVisibleCardIndex = 0.obs;

  int get currentVisibleCardIndex => _currentVisibleCardIndex.value;

  void updateVisibleCardIndex(int index) {
    _currentVisibleCardIndex.value = index;
  }
}
