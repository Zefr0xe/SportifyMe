import 'package:flutter/material.dart';
import '../models/quest.dart';
import '../utils/constants.dart';

class QuestProvider extends ChangeNotifier {
  List<Quest> _dailyQuests = [
    Quest(
      id: 'daily_pushup',
      name: 'Push Up',
      type: AppConstants.questTypePushUp,
      target: 10,
      current: 0,
      iconPath: 'assets/images/char_pushup.png',
      description: 'Do 10 push-ups',
      reward: 50,
    ),
    Quest(
      id: 'daily_running',
      name: 'Running',
      type: AppConstants.questTypeRunning,
      target: 8,
      current: 0,
      iconPath: 'assets/images/char_running.png',
      description: 'Run 8km',
      reward: 100,
    ),
    Quest(
      id: 'daily_jumping',
      name: 'Jumping',
      type: AppConstants.questTypeJumping,
      target: 30,
      current: 0,
      iconPath: 'assets/images/char_jumping.png',
      description: 'Do 30 jumps',
      reward: 75,
    ),
  ];

  List<Quest> _mainQuests = [
    Quest(
      id: 'main_jumps',
      name: 'The First Leap',
      type: AppConstants.questTypeJumping,
      target: 10,
      current: 0,
      iconPath: 'assets/images/char_jumping.png',
      description: 'Do 10 vertical jumps',
      chapterTitle: 'Chapter 1: Awakening',
      storyDescription:
          'You wake up in a strange world. Your legs feel heavy, but you must move. Jump to test your strength!',
    ),
    Quest(
      id: 'main_situp',
      name: 'Core of Steel',
      type: 'Sit Up',
      target: 15,
      current: 0,
      iconPath: 'assets/images/char_pushup.png',
      description: 'Do sit-ups and stretches',
      isLocked: true,
      chapterTitle: 'Chapter 2: Resilience',
      storyDescription:
          'The path ahead is blocked by a fallen tree. You need core strength to lift it. Train your abs!',
    ),
    Quest(
      id: 'main_pushup',
      name: 'Push Through',
      type: AppConstants.questTypePushUp,
      target: 20,
      current: 0,
      iconPath: 'assets/images/char_pushup.png',
      description: 'Do complex and intense',
      isLocked: true,
      chapterTitle: 'Chapter 3: Power',
      storyDescription:
          'A giant boulder blocks the cave entrance. Only raw power can move it. Push your limits!',
    ),
    Quest(
      id: 'main_run',
      name: 'The Great Escape',
      type: AppConstants.questTypeRunning,
      target: 5,
      current: 0,
      iconPath: 'assets/images/char_running.png',
      description: 'Run for endurance',
      isLocked: true,
      chapterTitle: 'Chapter 4: Freedom',
      storyDescription:
          'The beast is chasing you! Run as fast as you can to escape the forest and find freedom.',
    ),
  ];

  List<Quest> get dailyQuests => _dailyQuests;
  List<Quest> get mainQuests => _mainQuests;

  void updateQuestProgress(String questId, int newCurrent) {
    // Update daily quests
    final dailyIndex = _dailyQuests.indexWhere((q) => q.id == questId);
    if (dailyIndex != -1) {
      _dailyQuests[dailyIndex] = _dailyQuests[dailyIndex].copyWith(
        current: newCurrent,
      );
      notifyListeners();
      return;
    }

    // Update main quests
    final mainIndex = _mainQuests.indexWhere((q) => q.id == questId);
    if (mainIndex != -1) {
      final updatedQuest = _mainQuests[mainIndex].copyWith(
        current: newCurrent,
      );
      _mainQuests[mainIndex] = updatedQuest;

      // Check if quest is completed and unlock the next one
      if (updatedQuest.isCompleted && mainIndex < _mainQuests.length - 1) {
        final nextQuest = _mainQuests[mainIndex + 1];
        if (nextQuest.isLocked) {
          _mainQuests[mainIndex + 1] = nextQuest.copyWith(isLocked: false);
        }
      }

      notifyListeners();
    }
  }

  Quest? getQuestById(String questId) {
    try {
      return _dailyQuests.firstWhere((q) => q.id == questId);
    } catch (e) {
      try {
        return _mainQuests.firstWhere((q) => q.id == questId);
      } catch (e) {
        return null;
      }
    }
  }

  void resetDailyQuests() {
    for (int i = 0; i < _dailyQuests.length; i++) {
      _dailyQuests[i] = _dailyQuests[i].copyWith(current: 0);
    }
    notifyListeners();
  }
}
