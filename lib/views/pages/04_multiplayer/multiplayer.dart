import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/local_play_controller.dart';
import '../../../controllers/multiplayer_controller.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';

import '../../widgets/bouncing_arrow.dart';
import '../02_home/home.dart';
import '../05_game/game.dart';

class MultiplayerScreen extends StatelessWidget {
  final String username;
  final String lobbyCode;
  const MultiplayerScreen(
      {Key? key, required this.username, required this.lobbyCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final multiplayerController = Get.put(MultiplayerController());
    multiplayerController.setInitialUsername(username);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            // Delete the lobby before navigating back
            await multiplayerController.deleteLobby(lobbyCode);
            // Navigate back

            Get.delete<LocalPlayController>();
            Get.delete<HomeController>();
            Get.to(() => HomeScreen());
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              // Multiplayer Header Text
              Center(
                child: Text(
                  "Multiplayer Lobby",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Code display
              lobbyCode.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          "Lobby code:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        SelectableText(
                          lobbyCode,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  : SizedBox.shrink(),

              // Lobby Queue Header Text
              Center(
                child: Text(
                  "Pre-Game Lobby Members!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Add the hintText above the Container
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                  child: Text(
                    "2 players required & 8 max players!",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
              // Container holding all usernames of people that are playing
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light grey color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: GetBuilder<MultiplayerController>(
                  builder: (multiplayerController) {
                    return Container(
                      width: 400, // Set the fixed width
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiplayerController.usernames
                            .map((user) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          user.length > 15
                                              ? user.substring(0, 15)
                                              : user,
                                        ),
                                      ),
                                      // Show trash icon only if the user is not the host
                                      user != username
                                          ? IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                // Show confirmation dialog
                                                _showKickConfirmation(
                                                  context,
                                                  user,
                                                  () => multiplayerController
                                                      .usernames
                                                      .remove(user),
                                                );
                                              },
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              // Spacer to push the button to the bottom
              Spacer(),
              // LET'S PLAY button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => GameScreen(isMultiplayer: true));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("LET'S PLAY!"),
                    SizedBox(width: 10), // Add space between text and icon
                    BouncingArrow(),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showKickConfirmation(
      BuildContext context, String playerName, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Kick Player'),
        content: Text('Are you sure you want to kick $playerName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: Text('Kick'),
          ),
        ],
      ),
    );
  }
}
