import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quest_provider.dart';
import '../utils/colors.dart';
import '../widgets/quest_card.dart';
import 'activity_tracking_screen.dart';
import 'quest_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0; // 0: Daily Quest, 1: Main Quest

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Tab switcher
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      label: 'Daily Quest',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTabButton(
                      label: 'Main Quest',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: _selectedTab == 0
                  ? _buildDailyQuestView()
                  : _buildMainQuestView(),
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

  Widget _buildDailyQuestView() {
    return Consumer<QuestProvider>(
      builder: (context, questProvider, child) {
        final dailyQuests = questProvider.dailyQuests;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: dailyQuests.length,
          itemBuilder: (context, index) {
            final quest = dailyQuests[index];
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 400 + (index * 100)),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: QuestCard(
                quest: quest,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityTrackingScreen(
                        questId: quest.id,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildParticle(
      {required double left, required double bottom, required int delay}) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value < 0.5 ? value * 2 : (1.0 - value) * 2,
            child: Transform.translate(
              offset: Offset(0, -value * 50),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle, // Pixel shape
                ),
              ),
            ),
          );
        },
        onEnd: () {}, // Loop manually if needed
      ),
    );
  }

  Widget _buildMainQuestView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Gym building image with floating animation and effects
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Dynamic Shadow
                Positioned(
                  bottom: 40,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.8),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    onEnd: () {},
                  ),
                ),
                // Floating Building
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 15.0),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -value), // Move up
                      child: child,
                    );
                  },
                  onEnd: () {},
                  child: Image.asset(
                    'assets/images/gym_building.png',
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.fitness_center,
                        size: 80,
                        color: AppColors.textPrimary,
                      );
                    },
                  ),
                ),
                // Particles
                _buildParticle(left: 80, bottom: 100, delay: 0),
                _buildParticle(left: 250, bottom: 150, delay: 500),
                _buildParticle(left: 100, bottom: 200, delay: 1000),
                _buildParticle(left: 220, bottom: 80, delay: 1500),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Start button with game style
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuestDetailScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.darkCyan, Color(0xFF0077AA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkCyan.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 0, // Hard shadow for 3D effect
                  ),
                ],
              ),
              child: const Text(
                'START ADVENTURE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
