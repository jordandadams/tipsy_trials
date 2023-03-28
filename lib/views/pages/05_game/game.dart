import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/05_game/side_menu.dart';
import '../../../controllers/current_questions_controller.dart';
import '../../../controllers/questions_controller.dart';
import 'package:get/get.dart';
import '../../../controllers/local_play_controller.dart';
import '../../../controllers/visible_card_controller.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final QuestionController _questionController = Get.put(QuestionController());
  final CurrentQuestionsController _currentQuestionsController =
      Get.put(CurrentQuestionsController());
  final VisibleCardIndexController _visibleCardIndexController =
      Get.put(VisibleCardIndexController());

  final localPlayController = Get.find<LocalPlayController>();
  List<String> currentQuestions = List.filled(3, '');
  List<Map<String, dynamic>> cardQuestions = [];
  int _currentVisibleCardIndex = 0;
  Map<String, dynamic>? _nextQuestion;

  CardController _cardController = CardController();

  @override
  void initState() {
    super.initState();
    _questionController.loadInitialQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => _questionController.cardQuestions.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    children: [
                      Expanded(
                        child: TinderSwapCard(
                          orientation: AmassOrientation.bottom,
                          totalNum: _questionController.cardQuestions
                              .length, // Use the total number of questions
                          stackNum:
                              300, // Number of cards in the stack (including the top card)
                          maxWidth: MediaQuery.of(context).size.width *
                              0.9, // Width of the top card
                          maxHeight: MediaQuery.of(context).size.width *
                              1.2, // Height of the top card
                          minWidth: MediaQuery.of(context).size.width *
                              0.85, // Width of the bottom card
                          minHeight: MediaQuery.of(context).size.width *
                              1.15, // Height of the bottom card
                          cardBuilder: (context, index) {
                            // Use the index directly
                            final question =
                                _questionController.cardQuestions[index];
                            return _buildQuestionCard(question);
                          },
                          cardController: _cardController,
                          swipeUpdateCallback:
                              (DragUpdateDetails details, Alignment align) {},
                          swipeCompleteCallback:
                              (CardSwipeOrientation orientation, int index) {
                            _questionController.cardQuestions[index] =
                                _questionController.nextQuestion!;
                            _questionController.nextQuestion =
                                _questionController.getRandomQuestion();
                            // Update the current visible card index
                            _currentVisibleCardIndex = (index + 1) %
                                _questionController.cardQuestions.length;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          // Pass the question from the currently visible card
                          children: _buildPlayerButtons(_questionController
                              .cardQuestions[_currentVisibleCardIndex]),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      drawer: SideMenu(),
    );
  }

  List<Widget> _buildPlayerButtons(Map<String, dynamic> question) {
    return List<Widget>.generate(localPlayController.usernames.length, (index) {
      String player = localPlayController.usernames[index];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: ElevatedButton(
          onPressed: () {
            // Store the question of the currently visible card
            final currentQuestion = question;
            Get.dialog(
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currentQuestion["question"]), // Use stored question
                    SizedBox(height: 25),
                    Text(
                      'Player voted: $player',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Next Question'),
                    onPressed: () {
                      Get.back();
                      _cardController.triggerRight();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text(player),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Transform.scale(
      scale: 0.75,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 237, 229, 213),
          border: Border.all(
            color: Color.fromARGB(255, 7, 79, 81),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
              child: Text(
                question["type"],
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 79, 81),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: Color.fromARGB(255, 7, 79, 81)),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
                  child: Text(
                    question["question"] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 79, 81),
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
