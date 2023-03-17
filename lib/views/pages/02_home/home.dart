import 'package:flutter/material.dart';
import 'package:tipsy_trials/constants/app_colors.dart';
import 'package:tipsy_trials/views/pages/03_start/start.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your username...',
                        border: OutlineInputBorder(),
                      ),
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
                    Obx(() {
                      return ElevatedButton(
                        onPressed: () {
                          homeController.setSelectedMode('multiplayer');
                        },
                        child: Text(
                          'Multiplayer',
                          style: TextStyle(
                              color: homeController.selectedMode.value ==
                                      'multiplayer'
                                  ? AppColors.primaryColor
                                  : Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor:
                              homeController.selectedMode.value == 'multiplayer'
                                  ? AppColors.accentColor
                                  : AppColors.primaryColor,
                          side: BorderSide(
                            color: homeController.selectedMode.value ==
                                    'multiplayer'
                                ? AppColors.primaryColor
                                : Colors.transparent,
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 15),

                    // Local Play button
                    Obx(() {
                      return ElevatedButton(
                        onPressed: () {
                          homeController.setSelectedMode('local');
                        },
                        child: Text(
                          'Local Play',
                          style: TextStyle(
                              color: homeController.selectedMode.value ==
                                      'local'
                                  ? AppColors.primaryColor
                                  : Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor:
                              homeController.selectedMode.value == 'local'
                                  ? AppColors.accentColor
                                  : AppColors.primaryColor,
                          side: BorderSide(
                            color: homeController.selectedMode.value == 'local'
                                ? AppColors.primaryColor
                                : Colors.transparent,
                          ),
                        ),
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
