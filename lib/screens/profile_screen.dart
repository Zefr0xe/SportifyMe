import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header (Reusing CustomAppBar logic but customized for this screen if needed,
            // or just using CustomAppBar. The image shows the exact same header)
            const CustomAppBar(),

            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final userStats = userProvider.userStats;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Rank Progress
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF005580), // Darker blue for background
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userStats.playerRank,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                              const Text(
                                '0/100', // Placeholder for rank progress
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Character and Equipment Layout
                        SizedBox(
                          height: 400,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Character (Center)
                              Positioned(
                                top: 50,
                                child: Container(
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    userStats.avatarPath,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.none,
                                  ),
                                ),
                              ),

                              // Equipment Slots (Left Side)
                              Positioned(
                                left: 20,
                                top: 20,
                                child: _buildEquipmentSlot('Helmet'),
                              ),
                              Positioned(
                                left: 20,
                                top: 120,
                                child: _buildEquipmentSlot('Armor'),
                              ),
                              Positioned(
                                left: 20,
                                top: 220,
                                child: _buildEquipmentSlot('Sword'),
                              ),

                              // Equipment Slots (Right Side)
                              Positioned(
                                right: 20,
                                top: 20,
                                child: _buildEquipmentSlot('Legging'),
                              ),
                              Positioned(
                                right: 20,
                                top: 120,
                                child: _buildEquipmentSlot('Boots'),
                              ),
                              Positioned(
                                right: 20,
                                top: 220,
                                child: _buildEquipmentSlot('Accessories'),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Auto Equip Button
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement auto equip logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Auto Equip Coming Soon!')),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF005580),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 4),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: const Text(
                              'Auto Equip',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pixel',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Nav (Visual only, or functional if needed)
            // Since this is a pushed screen, we might want to show it for consistency
            // but it won't navigate tabs unless we restructure.
            // For now, let's include it to match the design but make it pop back or just be visual.
            BottomNav(
              currentIndex: -1, // No tab selected
              onTap: (index) {
                Navigator.pop(context); // Go back to main screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentSlot(String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF005580),
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
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pixel',
          ),
        ),
      ),
    );
  }
}
