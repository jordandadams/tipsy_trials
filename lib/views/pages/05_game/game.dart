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
                        return _buildQuestionCard(question);
                      }),
                      onCardSwiped: (dir, index, widget) {
                        _cardController.addItem(
                          _buildQuestionCard(
                              _questionController.getRandomQuestion()),
                        );
                      },
                    ),
                    // Add your buttons here
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Button 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Button 2'),
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
