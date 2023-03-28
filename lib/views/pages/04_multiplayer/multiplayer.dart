import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../controllers/multiplayer_controller.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';

class MultiplayerScreen extends StatelessWidget {
  final String username;
  const MultiplayerScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final multiplayerController = Get.put(MultiplayerController());
    multiplayerController.setInitialUsername(username);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
              SizedBox(height: 40),
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
                child: Obx(
                  () => Container(
                    width: 400, // Set the fixed width
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: multiplayerController.usernames
                          .map((user) => Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        // Show confirmation dialog
                                        _showKickConfirmation(
                                          context,
                                          user,
                                          () => multiplayerController.usernames
                                              .remove(user),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
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
