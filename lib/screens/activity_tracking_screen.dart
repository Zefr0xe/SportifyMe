import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../providers/quest_provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class ActivityTrackingScreen extends StatefulWidget {
  final String questId;

  const ActivityTrackingScreen({
    super.key,
    required this.questId,
  });

  @override
  State<ActivityTrackingScreen> createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  int _currentCount = 0;

  @override
  void initState() {
    super.initState();
    // Load current progress
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quest = context.read<QuestProvider>().getQuestById(widget.questId);
      if (quest != null) {
        setState(() {
          _currentCount = quest.current;
        });
      }
    });
  }

  void _incrementCount(Quest quest) {
    if (_currentCount < quest.target) {
      setState(() {
        _currentCount++;
      });
      context
          .read<QuestProvider>()
          .updateQuestProgress(widget.questId, _currentCount);

      // Check if completed
      if (_currentCount >= quest.target && !quest.isCompleted) {
        _showCompletionDialog(quest);
      }
    }
  }

  void _showCompletionDialog(Quest quest) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Quest Completed!',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed ${quest.name}!',
              style: const TextStyle(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            if (quest.reward != null) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on,
                      color: AppColors.coinYellow),
                  const SizedBox(width: 4),
                  Text(
                    '+${quest.reward}',
                    style: const TextStyle(
                      color: AppColors.coinYellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (quest.reward != null) {
                context.read<UserProvider>().addCoins(quest.reward!);
              }
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to home
            },
            child: const Text(
              'Claim Reward',
              style: TextStyle(color: AppColors.cardBorder),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestProvider>(
      builder: (context, questProvider, child) {
        final quest = questProvider.getQuestById(widget.questId);

        if (quest == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.darkCyan,
              title: const Text('Quest Not Found'),
            ),
            body: const Center(
              child: Text(
                'Quest not found',
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          );
        }

        // Check if it's a Main Quest (RPG Mode)
        if (quest.chapterTitle != null) {
          return _buildRPGView(quest);
        }

        // Standard Daily Quest View
        return _buildStandardView(quest);
      },
    );
  }

  Widget _buildStandardView(Quest quest) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      appBar: AppBar(
        backgroundColor: AppColors.darkCyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          quest.name,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Quest icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.darkCyan,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  quest.iconPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.fitness_center,
                      color: AppColors.textPrimary,
                      size: 60,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                quest.name.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Counter display
            Container(
              width: 280,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.cardBorder, width: 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total ${quest.name}s',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_currentCount / ${quest.target}',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    '${_getUnit(quest.type)}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Increment button
            GestureDetector(
              onTap: () => _incrementCount(quest),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _currentCount >= quest.target
                        ? [Colors.green, Colors.green.shade700]
                        : [AppColors.accentOrange, AppColors.coinYellow],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  _currentCount >= quest.target ? Icons.check : Icons.add,
                  size: 80,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Back button
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkCyan,
                foregroundColor: AppColors.textPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRPGView(Quest quest) {
    final enemyHp = quest.target - _currentCount;
    final hpPercentage = (enemyHp / quest.target).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Dark RPG Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          quest.chapterTitle ?? 'Battle',
          style: const TextStyle(
            color: AppColors.accentOrange,
            fontFamily: 'Pixel',
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Effect (Gradient)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E).withOpacity(0.8),
                  const Color(0xFF0F3460),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Enemy Name & HP Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      Text(
                        'BOSS: ${quest.name.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'Pixel',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // HP Bar Container
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Stack(
                          children: [
                            // Red HP Fill
                            FractionallySizedBox(
                              widthFactor: hpPercentage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            // HP Text
                            Center(
                              child: Text(
                                '$enemyHp / ${quest.target} HP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Enemy Sprite
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    quest.iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.warning,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                ),

                const Spacer(),

                // Battle Controls
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    border: const Border(
                      top: BorderSide(color: AppColors.accentOrange, width: 4),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        quest.storyDescription ?? 'Defeat the enemy!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Attack Button
                          GestureDetector(
                            onTap: () => _incrementCount(quest),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    offset: const Offset(0, 4),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.flash_on,
                                      color: Colors.white, size: 32),
                                  Text(
                                    'ATTACK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Pixel',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Info Panel
                          Column(
                            children: [
                              const Text(
                                'DAMAGE',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Pixel',
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                '${_currentCount * 10}', // Mock damage calculation
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pixel',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getUnit(String type) {
    if (type.toLowerCase().contains('running') ||
        type.toLowerCase().contains('run')) {
      return 'Times';
    }
    return 'Times';
  }
}
