import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsy_trials/controllers/multiplayer_controller.dart';
import 'package:tipsy_trials/views/pages/02_home/home.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/local_play_controller.dart';

class SideMenu extends StatelessWidget {
  final bool isMultiplayer;
  final String? lobbyCode;
  final String? playerName;
  const SideMenu(
      {Key? key,
      required this.isMultiplayer,
      this.lobbyCode = '',
      this.playerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localPlayController = Get.find<LocalPlayController>();
    final homeController = Get.find<HomeController>();
    final multiplayerController = Get.find<MultiplayerController>();

    if (isMultiplayer && lobbyCode!.isNotEmpty) {
      multiplayerController.listenToPlayersInLobby(lobbyCode);
    }

    return Container(
      width: 200,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 70, 16, 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pause Menu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ExpansionTile(
                  title: Text(
                    'Players',
                    style: TextStyle(fontSize: 18),
                  ),
                  children: isMultiplayer
                      ? List.generate(
                          multiplayerController.usernames.length,
                          (index) => ListTile(
                            title: Text(multiplayerController.usernames[index]),
                          ),
                        )
                      : List.generate(
                          localPlayController.usernames.length,
                          (index) => ListTile(
                            title: Text(localPlayController.usernames[index]),
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: ElevatedButton(
                onPressed: () async {
                  if (isMultiplayer) {
                    // Remove player from the lobby
                    await multiplayerController.removePlayerFromLobby(
                        lobbyCode!, playerName!);
                    // Check the number of players remaining in the lobby
                    int remainingPlayers =
                        multiplayerController.usernames.length;
                    // If less than 2 players, delete the lobby
                    if (remainingPlayers < 2) {
                      await multiplayerController.deleteLobby(lobbyCode!);
                    }
                  }
                  // Reset GetX state for the player
                  localPlayController.resetState();
                  Get.delete<LocalPlayController>();
                  Get.delete<HomeController>();
                  Get.to(() => HomeScreen());
                },
                child: Text('Quit Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
