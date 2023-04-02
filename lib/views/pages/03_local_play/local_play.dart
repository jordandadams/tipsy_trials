import 'package:flutter/material.dart';
import 'package:tipsy_trials/views/pages/05_game/game.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import '../../../controllers/local_play_controller.dart';
import '../../widgets/add_user_input_field.dart';
import '../../widgets/bouncing_arrow.dart';

class LocalPlayScreen extends StatelessWidget {
  final String username;
  const LocalPlayScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localPlayController = Get.put(LocalPlayController());
    localPlayController.setInitialUsername(username);

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
              // Local Play Header Text
              Center(
                child: Text(
                  "Local Play Lobby",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 40),

              // Those Drinking Header Text
              Center(
                child: Text(
                  "Those Ready to Drink!",
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
                      children: localPlayController.usernames
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
                                    // Show trash icon only if the user is not the one who started the game
                                    user != username
                                        ? IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              localPlayController.usernames
                                                  .remove(user);
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),

              Obx(
                () => localPlayController.showInputField.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return localPlayController
                                    .errorMessage.value.isEmpty
                                ? SizedBox.shrink()
                                : Text(
                                    localPlayController.errorMessage.value,
                                    style: TextStyle(color: Colors.red),
                                  );
                          }),
                          AddUserField(
                            onChanged: (_) =>
                                localPlayController.validateForm(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Cancel button
                              IconButton(
                                onPressed: () {
                                  localPlayController.toggleInputField();
                                  localPlayController.usernameController
                                      .clear();
                                },
                                icon: Icon(Icons.cancel),
                              ),
                              SizedBox(width: 5),
                              // Use Obx to listen to canProceed value
                              Obx(() {
                                return IconButton(
                                  onPressed:
                                      localPlayController.canProceed.value
                                          ? () => localPlayController.addPlayer(
                                              localPlayController
                                                  .usernameController.text)
                                          : null,
                                  icon: Icon(Icons.add),
                                );
                              }),
                            ],
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: localPlayController.toggleInputField,
                        child: Text('+ ADD PLAYER'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .primaryColor, // You can set the button color here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Change the corner radius for rounded edges
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical:
                                  10), // Adjust the padding for a smaller size
                        ),
                      ),
              ),

              // Spacer to push the button to the bottom
              Spacer(),

              // LET'S PLAY button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => GameScreen());
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
}
