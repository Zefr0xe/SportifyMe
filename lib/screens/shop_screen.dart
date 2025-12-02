import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedTab = 0; // 0: General, 1: Membership, 2: Gacha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        child: Row(
          children: [
            // LEFT SIDEBAR
            Container(
              width: 80,
              color: const Color(0xFF005580), // Dark Sidebar
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // General Shop Tab
                  _buildSidebarTab(
                    icon: Icons.person_outline,
                    isSelected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                  const SizedBox(height: 20),
                  // Membership Shop Tab
                  _buildSidebarTab(
                    icon: Icons.star_border,
                    isSelected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                  const SizedBox(height: 20),
                  // Gacha Tab
                  _buildSidebarTab(
                    icon: Icons.casino, // Gacha Icon
                    isSelected: _selectedTab == 2,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                  const Spacer(),
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004466),
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
                        child: const Center(
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // RIGHT CONTENT AREA
            Expanded(
              child: Column(
                children: [
                  // Info Box (Top)
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF005580),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'INFO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pixel',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getInfoText(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Pixel',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Header Strip
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF66AACC),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getTabIcon(),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _getTabTitle(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Pixel',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subtitle Strip
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF66AACC),
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 2),
                        right: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    child: Text(
                      _getSubtitleText(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Pixel',
                      ),
                    ),
                  ),

                  // Content Grid/List
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF005580),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: SingleChildScrollView(
                        child: _buildContent(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInfoText() {
    switch (_selectedTab) {
      case 0:
        return 'Items that you frequently use can be purchased.';
      case 1:
        return 'Access premium products and special offers with your membership.';
      case 2:
        return 'Try your luck! Win rare items and equipment.';
      default:
        return '';
    }
  }

  IconData _getTabIcon() {
    switch (_selectedTab) {
      case 0:
        return Icons.person_outline;
      case 1:
        return Icons.star;
      case 2:
        return Icons.casino;
      default:
        return Icons.help;
    }
  }

  String _getTabTitle() {
    switch (_selectedTab) {
      case 0:
        return 'General Shop';
      case 1:
        return 'Membership Shop';
      case 2:
        return 'Gacha Shop';
      default:
        return '';
    }
  }

  String _getSubtitleText() {
    switch (_selectedTab) {
      case 0:
        return 'You can purchase items you need at any time.';
      case 1:
        return 'You can unlock exclusive benefits as a member.';
      case 2:
        return 'Spend diamonds to open the Mystery Chest!';
      default:
        return '';
    }
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 0:
        return _buildGeneralShopGrid();
      case 1:
        return _buildMembershipShopList();
      case 2:
        return _buildGachaView();
      default:
        return const SizedBox();
    }
  }

  Widget _buildSidebarTab({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildGachaView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Chest Animation/Image
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB0E0E6)
                    .withOpacity(0.5), // Diamond color glow
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.inventory_2, // Chest Icon
            size: 80,
            color: Color(0xFFB0E0E6), // Diamond color
          ),
        ),
        const SizedBox(height: 40),

        // Pull Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGachaButton(
              label: 'Pull 1x',
              cost: 100,
              onTap: () => _performGacha(1),
            ),
            _buildGachaButton(
              label: 'Pull 10x',
              cost: 900,
              isSpecial: true,
              onTap: () => _performGacha(10),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Possible Rewards:\nRare Equipment, Potions, Coins',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildGachaButton({
    required String label,
    required int cost,
    required VoidCallback onTap,
    bool isSpecial = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSpecial ? AppColors.accentOrange : AppColors.primaryCyan,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pixel',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.diamond,
                    color: Colors.white, size: 16), // Diamond Icon
                const SizedBox(width: 4),
                Text(
                  '$cost',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pixel',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _performGacha(int pulls) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cost = pulls == 1 ? 100 : 900;

    if (userProvider.userStats.gems >= cost) {
      userProvider.spendGems(cost);

      // Mock Gacha Result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF005580),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          title: const Text(
            'Gacha Result!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pixel',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: AppColors.coinYellow, size: 60),
              const SizedBox(height: 16),
              Text(
                'You got $pulls item(s)!',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Iron Sword x1', // Placeholder result
                style: TextStyle(
                  color: AppColors.accentOrange,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pixel',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough diamonds!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildGeneralShopGrid() {
    final items = [
      {
        'name': 'Fire Helmet',
        'price': 800,
        'icon': Icons.local_fire_department
      },
      {'name': 'Ice Armor', 'price': 800, 'icon': Icons.ac_unit},
      {'name': 'Dragon Sword', 'price': 1000, 'icon': Icons.hardware},
      {'name': 'Black Legging', 'price': 300, 'icon': Icons.accessibility},
      {'name': 'Gold Boots', 'price': 500, 'icon': Icons.directions_run},
      {'name': 'Shadow Hat', 'price': 800, 'icon': Icons.create},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65, // Adjusted for taller cards
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildShopItem(
          item['name'] as String,
          item['price'] as int,
          item['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildShopItem(String name, int price, IconData icon) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Pixel',
                height: 1.2,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/coin_pixel.png',
                    width: 14, height: 14),
                const SizedBox(width: 4),
                Text(
                  '$price',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Pixel',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipShopList() {
    return Column(
      children: [
        _buildMembershipCard(
          'Premium Membership - Silver',
          ['Elf\nEar', 'Ruby\nArrow', '30\nDiamond\n/month'],
          '\$4.99',
          const Color(0xFF004466), // Darker Blue
        ),
        const SizedBox(height: 16),
        _buildMembershipCard(
          'Premium Membership - Gold',
          ['Dragon\nArmor', 'Jade\nSword', '60\nDiamond\n/month'],
          '\$14.99',
          const Color(0xFF003344), // Even Darker Blue
        ),
      ],
    );
  }

  Widget _buildMembershipCard(
      String title, List<String> benefits, String price, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Pixel',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                benefits.map((benefit) => _buildBenefitItem(benefit)).toList(),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Pixel',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Container(
      width: 85,
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF66AACC), // Lighter blue slot
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Pixel',
            height: 1.2,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
