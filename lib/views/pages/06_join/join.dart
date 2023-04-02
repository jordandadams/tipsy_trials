import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/local_play_controller.dart';
import '../../themes/text.dart';

import '../../widgets/bouncing_arrow.dart';
import '../02_home/home.dart';

class JoinScreenController extends GetxController {
  RxList<String> digits = List.generate(5, (index) => '').obs;

  void onDigitChanged(int index, String digit) {
    digits[index] = digit;
  }
}

class JoinScreen extends StatelessWidget {
  final String username;
  const JoinScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinScreenController>(
      init: JoinScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
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
                      "Join A Multiplayer Lobby",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Secondary Header Text
                  Text(
                    "Enter Lobby Code",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Lobby Code Input Fields with specified width and larger font size
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 50,
                        child: TextFormField(
                          initialValue: controller.digits[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          onChanged: (value) {
                            controller.onDigitChanged(index, value);
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 30),

                  // LET'S PLAY button
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("JOIN"),
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
      },
    );
  }
}
