import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart'; // Add this import
import '../../controllers/local_play_controller.dart';
import '../../controllers/multiplayer_controller.dart';

class PlayerButtons extends StatefulWidget {
  final Map<String, dynamic> question;
  final bool isMultiplayer;
  final MultiplayerController multiplayerController;
  final LocalPlayController localPlayController;
  final CardController cardController; // Add this variable

  PlayerButtons({
    required this.question,
    required this.isMultiplayer,
    required this.multiplayerController,
    required this.localPlayController,
    required this.cardController, // Add this parameter
  });

  @override
  _PlayerButtonsState createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    List<String> playerNames = widget.isMultiplayer
        ? widget.multiplayerController.usernames
        : widget.localPlayController.usernames;
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(playerNames.length, (index) {
        String player = playerNames[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: ElevatedButton(
            onPressed: () {
              // Store the question of the currently visible card
              final currentQuestion = widget.question; // Update this line
              showDialog(
                context: context,
                useRootNavigator: false,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(currentQuestion["question"]),
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
                          Navigator.of(context).pop();
                          widget.cardController
                              .triggerRight(); // Update this line
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
                  );
                },
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
      }),
    );
  }
}
