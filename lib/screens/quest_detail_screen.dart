import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quest_provider.dart';
import '../utils/colors.dart';
import '../widgets/progress_bar.dart';

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
    return Row(
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
                    ? AppColors.textSecondary.withOpacity(0.3)
                    : AppColors.cardBorder,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.darkCyan,
                  width: 3,
                ),
              ),
              child: Icon(
                quest.isLocked ? Icons.lock : Icons.fitness_center,
                color: quest.isLocked ? AppColors.textSecondary : Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 3,
                height: 60,
                color: AppColors.cardBorder.withOpacity(0.5),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Quest info
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: quest.isLocked
                  ? AppColors.cardBackground.withOpacity(0.5)
                  : AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: quest.isLocked
                    ? AppColors.textSecondary.withOpacity(0.3)
                    : AppColors.cardBorder,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quest.name,
                  style: TextStyle(
                    color: quest.isLocked
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  quest.description ?? 'Complete this quest',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${quest.current} / ${quest.target}',
                  style: TextStyle(
                    color: quest.isLocked
                        ? AppColors.textSecondary
                        : AppColors.coinYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
