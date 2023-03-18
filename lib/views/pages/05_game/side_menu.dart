import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsy_trials/views/pages/02_home/home.dart';
import '../../../controllers/local_play_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localPlayController = Get.find<LocalPlayController>();

    return Container(
      width: 200,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Text('Menu'),
                ),
                ListTile(
                  title: Text('Players'),
                  trailing: Icon(Icons.arrow_drop_down),
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        content: Container(
                          width: double.maxFinite,
                          child: ListView.builder(
                            itemCount: localPlayController.usernames.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(localPlayController.usernames[index]),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Get.to(() => HomeScreen()),
                child: Text('Quit Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}