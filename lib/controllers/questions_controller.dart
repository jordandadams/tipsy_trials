import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  late List<dynamic> _questions;
  final Random _random = Random();

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/data/questions.json');
    final Map<String, dynamic> parsedData = jsonDecode(jsonString);
    _questions = parsedData["vote_cards"] +
        parsedData["truth_or_dare_cards"][0]["truth"] +
        parsedData["truth_or_dare_cards"][0]["dare"];
    update();
  }

  Map<String, dynamic> getRandomQuestion() {
    return _questions[_random.nextInt(_questions.length)];
  }
}
