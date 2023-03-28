import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  late List<dynamic> _questions;
  final Random _random = Random();
  final Set<int> _shownQuestionIndexes = {}; // Keep track of shown question indexes

  RxList<Map<String, dynamic>> cardQuestions = RxList<Map<String, dynamic>>([]);
  Map<String, dynamic>? nextQuestion;

  @override
  void onInit() {
    super.onInit();
    loadInitialQuestions();
  }

  Future<void> loadInitialQuestions() async {
    await loadQuestions();
    cardQuestions.assignAll(List.generate(300, (index) {
      return getRandomQuestion();
    }));
    // Pre-fetch next question
    nextQuestion = getRandomQuestion();
    update();
  }

  Future<void> loadQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/data/questions.json');
    final Map<String, dynamic> parsedData = jsonDecode(jsonString);

    _questions = parsedData["vote_cards"].map((question) {
          return {
            "type": "Vote",
            "question": question["question"],
          };
        }).toList() +
        parsedData["truth_or_dare_cards"][0]["truth"].map((question) {
          return {
            "type": "Truth",
            "question": question["question"],
          };
        }).toList() +
        parsedData["truth_or_dare_cards"][0]["dare"].map((question) {
          return {
            "type": "Dare",
            "question": question["question"],
          };
        }).toList();

    update();
  }

  Map<String, dynamic> getRandomQuestion() {
    // Check if all questions have been shown
    if (_shownQuestionIndexes.length == _questions.length) {
      _shownQuestionIndexes.clear(); // Reset the list of shown question indexes
    }

    int randomIndex;
    do {
      randomIndex = _random.nextInt(_questions.length);
    } while (_shownQuestionIndexes.contains(randomIndex));

    _shownQuestionIndexes.add(randomIndex);
    return _questions[randomIndex];
  }
}