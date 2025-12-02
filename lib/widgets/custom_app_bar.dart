import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'currency_display.dart';
import '../screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userStats = userProvider.userStats;

        return Container(
          padding:
              const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.darkCyan,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Player info
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.cardBorder, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            userStats.avatarPath,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person,
                                  color: AppColors.darkCyan);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userStats.playerName,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              userStats.playerRank,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Currency
              Row(
                children: [
                  CurrencyDisplay(
                    imagePath: 'assets/icons/gem_pixel.png',
                    color: AppColors.gemPurple,
                    amount: userStats.gems,
                    onAddPressed: () {
                      // TODO: Navigate to top up screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Top Up Gems Coming Soon!')),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  CurrencyDisplay(
                    imagePath: 'assets/icons/coin_pixel.png',
                    color: AppColors.coinYellow,
                    amount: userStats.coins,
                    onAddPressed: () {
                      // TODO: Navigate to top up screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Top Up Coins Coming Soon!')),
                      );
                    },
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
