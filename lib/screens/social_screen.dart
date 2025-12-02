import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  int _selectedTab = 0;

  // Mock Data for Friends
  final List<Map<String, dynamic>> _friends = [
    {
      'name': 'Budi Santoso',
      'rank': 'Pro',
      'avatar': 'assets/images/avatar_boy.png',
      'online': true
    },
    {
      'name': 'Siti Aminah',
      'rank': 'Expert',
      'avatar': 'assets/images/avatar_girl.png',
      'online': false
    },
    {
      'name': 'Joko Anwar',
      'rank': 'Beginner',
      'avatar': 'assets/images/avatar_boy.png',
      'online': true
    },
  ];

  // Mock Data for Leaderboard
  final List<Map<String, dynamic>> _leaderboard = [
    {
      'name': 'Rizky Billar',
      'score': 2500,
      'avatar': 'assets/images/avatar_boy.png',
      'rank': 1
    },
    {
      'name': 'Lesti Kejora',
      'score': 2450,
      'avatar': 'assets/images/avatar_girl.png',
      'rank': 2
    },
    {
      'name': 'Atta Halilintar',
      'score': 2300,
      'avatar': 'assets/images/avatar_boy.png',
      'rank': 3
    },
    {
      'name': 'Aurelie',
      'score': 2100,
      'avatar': 'assets/images/avatar_girl.png',
      'rank': 4
    },
    {
      'name': 'Raffi Ahmad',
      'score': 1900,
      'avatar': 'assets/images/avatar_boy.png',
      'rank': 5
    },
    {
      'name': 'Nagita Slavina',
      'score': 1850,
      'avatar': 'assets/images/avatar_girl.png',
      'rank': 6
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header removed as it is provided by MainScreen

            // Tab Switcher
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      label: 'Friends',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTabButton(
                      label: 'Leaderboard',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: _selectedTab == 0
                  ? _buildFriendsTab()
                  : _buildLeaderboardTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkCyan : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.cardBorder : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.cardBorder.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
              fontFamily: 'Pixel',
              shadows: isSelected
                  ? [
                      const Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    return Column(
      children: [
        // Add Friend Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Add Friend feature coming soon!')),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0077AA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Add Friend',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pixel',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Friends List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _friends.length,
            itemBuilder: (context, index) {
              final friend = _friends[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryCyan.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.darkCyan, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          friend['avatar'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person,
                                  color: AppColors.darkCyan),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            friend['name'],
                            style: const TextStyle(
                              fontFamily: 'Pixel',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            friend['rank'],
                            style: const TextStyle(
                              fontFamily: 'Pixel',
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: friend['online'] ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        friend['online'] ? 'Online' : 'Offline',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _leaderboard.length,
      itemBuilder: (context, index) {
        final user = _leaderboard[index];
        final isTop3 = index < 3;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isTop3
                ? const Color(0xFFFFF8E1)
                : Colors.white, // Gold tint for top 3
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isTop3 ? AppColors.accentOrange : Colors.black,
                width: isTop3 ? 3 : 2),
            boxShadow: [
              BoxShadow(
                color: isTop3
                    ? AppColors.accentOrange.withOpacity(0.2)
                    : Colors.black12,
                offset: const Offset(0, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              // Rank
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isTop3 ? AppColors.accentOrange : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${user['rank']}',
                  style: TextStyle(
                    color: isTop3 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pixel',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryCyan.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.darkCyan, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    user['avatar'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, color: AppColors.darkCyan),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name
              Expanded(
                child: Text(
                  user['name'],
                  style: const TextStyle(
                    fontFamily: 'Pixel',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              // Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${user['score']}',
                    style: const TextStyle(
                      fontFamily: 'Pixel',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.darkCyan,
                    ),
                  ),
                  const Text(
                    'pts',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
