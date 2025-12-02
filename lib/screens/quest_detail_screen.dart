import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../providers/quest_provider.dart';
import '../utils/colors.dart';
import '../widgets/progress_bar.dart';
import 'activity_tracking_screen.dart';

class QuestDetailScreen extends StatelessWidget {
  const QuestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCyan,
      appBar: AppBar(
        backgroundColor: AppColors.darkCyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Main Quest Page',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Consumer<QuestProvider>(
        builder: (context, questProvider, child) {
          final mainQuests = questProvider.mainQuests;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress overview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your progress',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomProgressBar(
                        progress: _calculateTotalProgress(mainQuests),
                        label: '95% to complete',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Quest timeline
                ...mainQuests.asMap().entries.map((entry) {
                  final index = entry.key;
                  final quest = entry.value;
                  final isLast = index == mainQuests.length - 1;

                  return _buildTimelineItem(
                    context,
                    quest: quest,
                    isLast: isLast,
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calculateTotalProgress(List quests) {
    if (quests.isEmpty) return 0.0;
    double total = 0.0;
    for (var quest in quests) {
      total += quest.progress;
    }
    return total / quests.length;
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required quest,
    required bool isLast,
  }) {
    return GestureDetector(
      onTap: () {
        if (!quest.isLocked) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityTrackingScreen(
                questId: quest.id,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Complete previous quest to unlock!'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: quest.isLocked
                      ? AppColors.primaryCyan.withOpacity(0.5)
                      : AppColors.primaryCyan,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: quest.isLocked
                        ? AppColors.textSecondary.withOpacity(0.5)
                        : AppColors.darkCyan,
                    width: 3,
                  ),
                  boxShadow: !quest.isLocked
                      ? [
                          BoxShadow(
                            color: AppColors.darkCyan.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: Icon(
                  quest.isLocked ? Icons.lock : Icons.fitness_center,
                  color:
                      quest.isLocked ? AppColors.textSecondary : Colors.white,
                  size: 20,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3,
                  height: 80, // Increased height for better spacing
                  color: AppColors.darkCyan.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Quest info
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: quest.isLocked
                    ? const Color(0xFF0088AA) // Darker/Locked color
                    : const Color(0xFF006699), // Active card color
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: quest.isLocked
                      ? Colors.transparent
                      : AppColors.cardBorder,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quest.name,
                        style: TextStyle(
                          color: quest.isLocked
                              ? Colors.white.withOpacity(0.7)
                              : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pixel',
                        ),
                      ),
                      if (quest.isCompleted)
                        const Icon(Icons.check_circle,
                            color: AppColors.coinYellow, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    quest.description ?? 'Complete this quest',
                    style: TextStyle(
                      color: quest.isLocked
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${quest.current} / ${quest.target}',
                    style: TextStyle(
                      color: quest.isLocked
                          ? Colors.white.withOpacity(0.5)
                          : AppColors.coinYellow,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pixel',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
