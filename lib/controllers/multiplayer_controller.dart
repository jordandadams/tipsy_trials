import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

import '../models/lobby.dart';

class MultiplayerController extends GetxController {
  final usernames = <String>[].obs;
  DatabaseReference _lobbiesRef =
      FirebaseDatabase.instance.ref().child('lobbies');

  String? _lobbyCode;

  String? get lobbyCode => _lobbyCode;

  String? username;

  void addUser(String username) {
    if (username.isNotEmpty) {
      usernames.add(username);
      this.username = username;
    }
  }

  void setInitialUsername(String username) {
    if (usernames.isEmpty) {
      addUser(username);
    }
  }

  Future<void> createLobby(String playerId) async {
    String lobbyCode = generateLobbyCode();
    await _lobbiesRef.child(lobbyCode).set({
      'lobbyCode': lobbyCode,
      'players': [playerId],
    });
    _lobbyCode = lobbyCode;
    this.username = playerId;
  }

  void joinLobby(String lobbyCode, String playerId) {
    _lobbiesRef.child(lobbyCode).child('players').update({
      playerId: true,
    });
  }

  void listenToPlayersInLobby(String? lobbyCode) {
    _lobbiesRef.child(lobbyCode!).child('players').onValue.listen((event) {
      List<String> playersList = [];
      if (event.snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> playersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        playersList = playersMap.keys.cast<String>().toList();
      }
      usernames.assignAll(playersList);
      update(); // Notify listeners about the update
    });
  }

  Stream<List<Lobby>> listenToLobbies() {
    return _lobbiesRef.onValue.map((event) {
      Map<dynamic, dynamic>? lobbies =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (lobbies != null) {
        return lobbies.values.map((lobby) {
          return Lobby(
            lobbyCode: lobby['lobbyCode'],
            players: List<String>.from(lobby['players']),
          );
        }).toList();
      } else {
        return [];
      }
    });
  }

  Future<void> removePlayerFromLobby(
      String lobbyCode, String playerName) async {
    await _lobbiesRef
        .child(lobbyCode)
        .child('players')
        .child(playerName)
        .remove();
  }

  Future<void> deleteLobby(String lobbyCode) async {
    // Remove the lobby from the Realtime Database based on the lobbyCode
    await _lobbiesRef.child(lobbyCode).remove();
  }

  String generateLobbyCode() {
    int code = Random().nextInt(90000) + 10000;
    return code.toString();
  }
}
