import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/05_game/side_menu.dart';
import '../../../controllers/current_questions_controller.dart';
import '../../../controllers/questions_controller.dart';
import 'package:get/get.dart';
import '../../../controllers/local_play_controller.dart';
import '../../../controllers/visible_card_controller.dart';

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

  SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();

  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();

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
        child: FutureBuilder(
          future: _questionController.loadQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    SwipeableCardsSection(
                      cardController: _cardController,
                      context: context,
                      items: List.generate(3, (index) {
                        Map<String, dynamic> question =
                            _questionController.getRandomQuestion();
                        cardQuestions.add(question);
                        return _buildQuestionCard(question);
                      }),
                      onCardSwiped: (dir, index, widget) {
                        Map<String, dynamic> newQuestion =
                            _questionController.getRandomQuestion();
                        _cardController.addItem(
                          _buildQuestionCard(newQuestion),
                        );
                        cardQuestions[index % 3] = newQuestion;
                        _visibleCardIndexController
                            .updateVisibleCardIndex((index + 1) % 3);
                      },
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: _buildPlayerButtons(),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawer: SideMenu(),
    );
  }

  List<Widget> _buildPlayerButtons() {
    return List<Widget>.generate(localPlayController.usernames.length, (index) {
      String player = localPlayController.usernames[index];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: ElevatedButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Text(cardQuestions[_visibleCardIndexController
                        .currentVisibleCardIndex]["question"])),
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
