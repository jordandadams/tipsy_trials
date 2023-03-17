import 'package:flutter/material.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/03_start/start.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
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

    // Set the initial border value
    homeController.setUsernameInputBorder(
      OutlineInputBorder(borderSide: homeController.defaultBorderSide()),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              Expanded(
                // Wrap the whole Column with Expanded
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
                    UsernameField(),

                    SizedBox(height: 20),

                    // Select Mode Heading Text
                    Text(
                      "SELECT MODE",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 15),

                    // Multiplayer button
                    Obx(() {
                      return SelectionButton(
                        text: 'Multiplayer',
                        onPressed: () =>
                            homeController.setSelectedMode('multiplayer'),
                        isSelected:
                            homeController.selectedMode.value == 'multiplayer',
                      );
                    }),

                    SizedBox(height: 15),

                    // Local Play button
                    Obx(() {
                      return SelectionButton(
                        text: 'Local Play',
                        onPressed: () =>
                            homeController.setSelectedMode('local'),
                        isSelected:
                            homeController.selectedMode.value == 'local',
                      );
                    }),
                  ],
                ),
              ),

              // START button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => StartScreen());
                },
                child: Text('START'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
