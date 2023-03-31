import 'package:flutter/material.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/03_local_play/local_play.dart';
import 'package:tipsy_trials/views/pages/04_multiplayer/multiplayer.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../controllers/multiplayer_controller.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/username_field.dart';

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

                    // Multiplayer button
                    SelectionButton(
                      text: 'Multiplayer',
                      onPressed: () =>
                          homeController.setSelectedMode('multiplayer'),
                      isSelected: homeController.isSelectedMultiplayer,
                    ),

                    SizedBox(height: 15),

                    // Local Play button
                    SelectionButton(
                      text: 'Local Play',
                      onPressed: () => homeController.setSelectedMode('local'),
                      isSelected: homeController.isSelectedLocalPlay,
                    ),
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
                            final multiplayerController =
                                Get.put(MultiplayerController());
                            final username =
                                homeController.usernameController.text;
                            await multiplayerController
                                .createLobby(username);
                            Get.to(() => MultiplayerScreen(
                                  username: username,
                                  lobbyCode: multiplayerController.lobbyCode!,
                                ));
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
}