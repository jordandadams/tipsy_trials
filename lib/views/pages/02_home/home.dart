import 'package:flutter/material.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/03_local_play/local_play.dart';
import 'package:tipsy_trials/views/pages/04_multiplayer/multiplayer.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../controllers/multiplayer_controller.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../controllers/home_controller.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/username_field.dart';
import '../06_join/join.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Get.put(HomeController()); // Initialize the HomeController

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 40),

                    // Logo
                    Center(
                      child: Image.asset(
                        AppImages.logo2,
                        height: 150, // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 35),

                    // Who's Drinking Heading Text
                    Text(
                      "Who's Drinking?",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 10),

                    // Who's Drinking Username Input Field
                    Column(
                      children: [
                        UsernameField(
                            onChanged: (_) => homeController.validateForm()),
                        Obx(() {
                          return homeController.errorMessage.value.isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  homeController.errorMessage.value,
                                  style: TextStyle(color: Colors.red),
                                );
                        }),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Select Mode Heading Text
                    Text(
                      "SELECT MODE",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 15),

                    GetBuilder<HomeController>(builder: (homeController) {
                      return Column(
                        children: [
                          // Multiplayer button
                          SelectionButton(
                            text: 'Multiplayer',
                            onPressed: () =>
                                homeController.setSelectedMode('multiplayer'),
                            isSelected: homeController.isSelectedMultiplayer
                                .value, // Pass the value directly
                          ),

                          SizedBox(height: 15),

                          // Local Play button
                          SelectionButton(
                            text: 'Local Play',
                            onPressed: () =>
                                homeController.setSelectedMode('local'),
                            isSelected: homeController.isSelectedLocalPlay
                                .value, // Pass the value directly
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),

              // START button
              Obx(() {
                return ElevatedButton(
                  onPressed: homeController.canProceed.value
                      ? () async {
                          if (homeController.selectedMode.value == 'local') {
                            Get.to(() => LocalPlayScreen(
                                username:
                                    homeController.usernameController.text));
                          } else if (homeController.selectedMode.value ==
                              'multiplayer') {
                            // Check internet connection
                            var connectivityResult =
                                await Connectivity().checkConnectivity();
                            if (connectivityResult == ConnectivityResult.none) {
                              // No internet connection
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('No Internet Connection'),
                                  content: Text(
                                      'Sorry, you must have an internet connection to play Multiplayer!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Has internet connection
                              showMultiplayerOptions(context,
                                  homeController.usernameController.text);
                            }
                          }
                        }
                      : null,
                  child: Text('START'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void showMultiplayerOptions(BuildContext context, String username) {
    final HomeController homeController =
        Get.find(); // Get the HomeController instance

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select an option!'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Keep column height to minimum
            children: [
              // Host button styled like on the home page
              Obx(() => SelectionButton(
                    text: 'Host',
                    onPressed: () {
                      // User selected "Host"
                      homeController.setSelectedMode('host');
                      final multiplayerController =
                          Get.put(MultiplayerController());
                      multiplayerController.createLobby(username).then((_) {
                        Get.to(() => MultiplayerScreen(
                              username: username,
                              lobbyCode: multiplayerController.lobbyCode!,
                            ));
                      });
                      Navigator.pop(context); // Close the dialog
                    },
                    isSelected: homeController.isSelectedHost.value,
                  )),
              SizedBox(height: 15), // Space between the buttons
              // Join button styled like on the home page
              Obx(() => SelectionButton(
                    text: 'Join',
                    onPressed: () {
                      // User selected "Join"
                      homeController.setSelectedMode('join');
                      // Navigate to the Join Screen (replace 'JoinScreen' with the actual class name)
                      Get.to(() => JoinScreen(username: username));
                    },
                    isSelected: homeController.isSelectedJoin.value,
                  )),
            ],
          ),
          actions: [
            // Dismiss text in the bottom right
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Dismiss'),
            ),
          ],
        );
      },
    );
  }
}
