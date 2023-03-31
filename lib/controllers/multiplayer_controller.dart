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

  void addUser(String username) {
    if (username.isNotEmpty) {
      usernames.add(username);
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
  }

  void joinLobby(String lobbyCode, String playerId) {
    _lobbiesRef.child(lobbyCode).child('players').update({
      playerId: true,
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

  String generateLobbyCode() {
    int code = Random().nextInt(90000) + 10000;
    return code.toString();
  }
}