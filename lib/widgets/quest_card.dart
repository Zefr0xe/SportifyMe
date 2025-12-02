import 'package:flutter/material.dart';
import '../models/quest.dart';
import '../utils/colors.dart';
import 'progress_bar.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  final VoidCallback? onTap;

  const QuestCard({
    super.key,
    required this.quest,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: quest.isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: quest.isLocked
              ? AppColors.cardBackground.withOpacity(0.5)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: quest.isLocked
                ? AppColors.textSecondary.withOpacity(0.3)
                : AppColors.cardBorder,
            width: 2,
          ),
          boxShadow: quest.isLocked
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.darkCyan,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder, width: 2),
              ),
              child: quest.isLocked
                  ? const Icon(
                      Icons.lock,
                      color: AppColors.textSecondary,
                      size: 30,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        quest.iconPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.fitness_center,
                            color: AppColors.textPrimary,
                            size: 30,
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quest.name,
                    style: TextStyle(
                      color: quest.isLocked
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Target: ${quest.current}/${quest.target}${_getUnit(quest.type)}',
                    style: TextStyle(
                      color: quest.isLocked
                          ? AppColors.textSecondary.withOpacity(0.7)
                          : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomProgressBar(
                    progress: quest.progress,
                    label: '',
                  ),
                ],
              ),
            ),
            // GO Button
            if (!quest.isLocked) ...[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accentOrange,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'GO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getUnit(String type) {
    if (type.toLowerCase().contains('running') ||
        type.toLowerCase().contains('run')) {
      return 'km';
    }
    return '';
  }
}
