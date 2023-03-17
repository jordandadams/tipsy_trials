import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';
import '../../../controllers/local_play_controller.dart';
import '../../widgets/add_user_input_field.dart';

class LocalPlayScreen extends StatelessWidget {
  final String username;
  const LocalPlayScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localPlayController = Get.put(LocalPlayController());
    final TextEditingController _usernameController = TextEditingController();

    localPlayController.addUser(username);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              SizedBox(height: 40),

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

              // Container holding all usernames of people that are playing
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light grey color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Obx(
                  () => Column(
                    children: localPlayController.usernames
                        .map((user) => Text(user))
                        .toList(),
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
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align the icons to the right
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
                onPressed: () {},
                child: Text("LET'S PLAY!"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
