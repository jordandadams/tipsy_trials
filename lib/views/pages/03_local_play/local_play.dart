import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import '../../../controllers/local_play_controller.dart';

class LocalPlayScreen extends StatelessWidget {
  final String username;
  const LocalPlayScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalPlayController localPlayController = Get.put(LocalPlayController());
    localPlayController.addUser(username);
    
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

                    // Local Play Header Text
                    Center(
                      child: Text(
                        "Local Play Lobby",
                        style:
                            TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 40),

                    // Those Drinking Header Text
                    Center(
                      child: Text(
                        "Those Ready to Drink!",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Container holding all usernames of people that are playing
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Light grey color
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: GetBuilder<LocalPlayController>(
                        builder: (controller) {
                          return Column(
                            children: controller.usernames
                                .map((user) => Text(user))
                                .toList(),
                          );
                        },
                      ),
                    ),

                    // Add player button

                    // Input field shown when add player button tapped

                    // Let's Play button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
