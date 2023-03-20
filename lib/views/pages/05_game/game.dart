import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:tipsy_trials/views/pages/05_game/side_menu.dart';
import '../../../controllers/questions_controller.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController _cardController = SwipeableCardSectionController();

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
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  SwipeableCardsSection(
                    cardController: _cardController,
                    context: context,
                    items: List.generate(3, (index) {
                      Map<String, dynamic> question = _questionController.getRandomQuestion();
                      return _buildQuestionCard(question);
                    }),
                    onCardSwiped: (dir, index, widget) {
                      _cardController.addItem(
                        _buildQuestionCard(_questionController.getRandomQuestion()),
                      );
                    },
                    enableSwipeUp: true,
                    enableSwipeDown: false,
                  ),
                ],
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

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          question["question"] ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}