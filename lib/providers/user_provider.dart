import 'package:flutter/material.dart';
import '../models/user_stats.dart';

class UserProvider extends ChangeNotifier {
  UserStats _userStats = UserStats(
    playerName: 'Player Name',
    playerRank: 'Beginner',
    gems: 1000,
    coins: 1000,
    avatarPath: 'assets/images/avatar_boy.png',
  );

  UserStats get userStats => _userStats;

  void setAvatar(String path) {
    _userStats = _userStats.copyWith(avatarPath: path);
    notifyListeners();
  }

  void addGems(int amount) {
    _userStats = _userStats.copyWith(gems: _userStats.gems + amount);
    notifyListeners();
  }

  void addCoins(int amount) {
    _userStats = _userStats.copyWith(coins: _userStats.coins + amount);
    notifyListeners();
  }

  void spendGems(int amount) {
    if (_userStats.gems >= amount) {
      _userStats = _userStats.copyWith(gems: _userStats.gems - amount);
      notifyListeners();
    }
  }

  void spendCoins(int amount) {
    if (_userStats.coins >= amount) {
      _userStats = _userStats.copyWith(coins: _userStats.coins - amount);
      notifyListeners();
    }
  }

  void updatePlayerInfo(String name, String rank) {
    _userStats = _userStats.copyWith(
      playerName: name,
      playerRank: rank,
    );
    notifyListeners();
  }
}
