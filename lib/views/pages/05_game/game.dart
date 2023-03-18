import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tipsy_trials/views/pages/05_game/side_menu.dart';
import '../../../controllers/questions_controller.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = true;
  final QuestionController _questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        child: GestureDetector(
          onTap: () {
            _controller.forward();
            setState(() {
              _isFront = !_isFront;
            });
          },
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()..setEntry(3, 2, 0.001),
                  child: _controller.value < 0.5 ? _buildFront() : _buildBack(),
                );
              },
            ),
          ),
        ),
      ),
      drawer: SideMenu(),
    );
  }

  Widget _buildFront() {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red,
      ),
      child: Center(child: Text('Tap to flip')),
    );
  }

  Widget _buildBack() {
    Map<String, dynamic> question = _questionController.getRandomQuestion();
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
