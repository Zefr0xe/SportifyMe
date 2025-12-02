class UserStats {
  final String playerName;
  final String playerRank;
  final int gems;
  final int coins;
  final String avatarPath;

  UserStats({
    required this.playerName,
    required this.playerRank,
    this.gems = 1000,
    this.coins = 1000,
    this.avatarPath = 'assets/images/avatar_boy.png',
  });

  UserStats copyWith({
    String? playerName,
    String? playerRank,
    int? gems,
    int? coins,
    String? avatarPath,
  }) {
    return UserStats(
      playerName: playerName ?? this.playerName,
      playerRank: playerRank ?? this.playerRank,
      gems: gems ?? this.gems,
      coins: coins ?? this.coins,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
