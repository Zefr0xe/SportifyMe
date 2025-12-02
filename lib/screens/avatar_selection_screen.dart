import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import 'main_screen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedAvatar;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _selectAvatar(String path) {
    setState(() {
      _selectedAvatar = path;
    });
  }

  void _continue() {
    if (_selectedAvatar != null && _nameController.text.isNotEmpty) {
      final userProvider = context.read<UserProvider>();
      userProvider.setAvatar(_selectedAvatar!);
      userProvider.updatePlayerInfo(_nameController.text, 'Beginner');

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Title
              const Text(
                'Who are you?',
                style: TextStyle(
                  fontFamily: 'Pixel',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Name Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: AppColors.accentOrange, width: 2),
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const Spacer(),
              // Avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvatarCard(
                    'Boy',
                    'assets/images/avatar_boy.png',
                    AppColors.darkCyan,
                  ),
                  const SizedBox(width: 20),
                  _buildAvatarCard(
                    'Girl',
                    'assets/images/avatar_girl.png',
                    AppColors.accentOrange,
                  ),
                ],
              ),
              const Spacer(),
              // Continue Button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      _selectedAvatar != null && _nameController.text.isNotEmpty
                          ? 1.0
                          : 0.0,
                  child: GestureDetector(
                    onTap: _continue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
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
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarCard(String label, String path, Color color) {
    final isSelected = _selectedAvatar == path;

    return GestureDetector(
      onTap: () => _selectAvatar(path),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        transform: Matrix4.identity()..scale(isSelected ? 1.1 : 1.0),
        child: Container(
          width: 140,
          height: 220,
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: Colors.white, width: 3)
                : Border.all(color: Colors.transparent, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar Image with Pixel Effect
              Container(
                decoration: isSelected
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      )
                    : null,
                child: Image.asset(
                  path,
                  width: 120,
                  height: 180,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.none, // Pixel art style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
