import 'package:get/get.dart';

class CurrentQuestionsController extends GetxController {
  RxList<String> currentQuestions = RxList<String>.filled(3, '');

  void updateQuestion(int index, String newQuestion) {
    currentQuestions[index] = newQuestion;
  }
}
