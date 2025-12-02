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
  bool _isGeneralShop = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header removed as it is provided by MainScreen

            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final userStats = userProvider.userStats;
                  // Determine which avatar to show based on selection,
                  // using the new v2 assets if available or falling back
                  String avatarPreview = userStats.avatarPath.contains('boy')
                      ? 'assets/images/avatar_boy_v2.png'
                      : 'assets/images/avatar_girl_v2.png';

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Character Preview
                        Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Image.asset(
                            avatarPreview,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to original if v2 not found (though we just copied them)
                              return Image.asset(
                                userStats.avatarPath,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.none,
                              );
                            },
                          ),
                        ),

                        // Info Box
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
                                _isGeneralShop
                                    ? 'Items that you frequently use can be purchased.'
                                    : 'Access premium products and special offers with your membership.',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Shop Tabs/Section Header
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF66AACC), // Lighter blue for header
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _isGeneralShop = true),
                                child: Icon(
                                  Icons.person_outline,
                                  color: _isGeneralShop
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  _isGeneralShop
                                      ? 'General Shop'
                                      : 'Membership Shop',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Pixel',
                                  ),
                                ),
                              ),
                              if (!_isGeneralShop)
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _isGeneralShop = true),
                                  child: const Icon(Icons.star,
                                      color: Colors.white),
                                ),
                            ],
                          ),
                        ),

                        // Subtitle
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF66AACC),
                            border: Border(
                              left: BorderSide(color: Colors.black, width: 2),
                              right: BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                          child: Text(
                            _isGeneralShop
                                ? 'You can purchase items you need at any time.'
                                : 'You can unlock exclusive benefits as a member.',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Pixel',
                            ),
                          ),
                        ),

                        // Items Grid
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF005580), // Dark background for items
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: _isGeneralShop
                              ? _buildGeneralShopGrid()
                              : _buildMembershipShopList(),
                        ),

                        const SizedBox(height: 20),

                        // Back Button (Visual)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                // Logic to go back or switch tab if needed
                                // For now, maybe just show a snackbar or do nothing as it's a main tab
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF005580),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 4),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.undo,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 8),
                                    Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Pixel',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        ),
      ),
    );
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
        childAspectRatio: 0.7,
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/coin_pixel.png',
                    width: 12, height: 12),
                const SizedBox(width: 4),
                Text(
                  '$price',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
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
          ['Elf Ear', 'Ruby Arrow', '30 Diamond/month'],
          '\$4.99',
          const Color(0xFF0077AA),
        ),
        const SizedBox(height: 16),
        _buildMembershipCard(
          'Premium Membership - Gold',
          ['Dragon Armor', 'Jade Sword', '60 Diamond/month'],
          '\$14.99',
          const Color(0xFF005580),
        ),
      ],
    );
  }

  Widget _buildMembershipCard(
      String title, List<String> benefits, String price, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Pixel',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                benefits.map((benefit) => _buildBenefitItem(benefit)).toList(),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: 'Pixel',
          ),
        ),
      ),
    );
  }
}
