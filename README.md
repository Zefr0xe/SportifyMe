# SportifyMe 🏋️‍♂️

A gamified fitness tracking Flutter application with pixel art aesthetics. Track your daily exercises, complete quests, and earn rewards!

## Features

✨ **Gamification Elements**
- Daily and Main Quest systems
- Progress tracking for exercises
- Currency system (Gems & Coins)
- Quest completion rewards

🎮 **Exercise Tracking**
- Push Ups counter
- Running distance tracker
- Jumping counter
- Real-time progress updates

🎨 **Beautiful UI**
- Pixel art character animations
- Cyan/blue color scheme
- Smooth progress bars
- Clean, modern interface

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone or download this repository

2. Navigate to the project directory:
```bash
cd SportifyMe
```

3. Get Flutter dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── quest.dart
│   └── user_stats.dart
├── providers/                # State management
│   ├── quest_provider.dart
│   └── user_provider.dart
├── screens/                  # App screens
│   ├── home_screen.dart
│   ├── activity_tracking_screen.dart
│   ├── quest_detail_screen.dart
│   ├── social_screen.dart
│   └── shop_screen.dart
├── widgets/                  # Reusable widgets
│   ├── custom_app_bar.dart
│   ├── quest_card.dart
│   ├── progress_bar.dart
│   ├── bottom_nav.dart
│   └── currency_display.dart
└── utils/                    # Utilities and constants
    ├── colors.dart
    └── constants.dart
```

## How to Use

### Home Screen
- Switch between **Daily Quest** and **Main Quest** tabs
- Tap on any quest card to start tracking that exercise
- View the gym building and tap **Start** to see the quest timeline

### Activity Tracking
- Tap the large circular button to increment your exercise count
- Progress automatically saves
- Complete quests to earn coin rewards
- Return to home screen anytime

### Quest System
- **Daily Quests**: Push Up (10), Running (8km), Jumping (30)
- **Main Quests**: Progressive challenges with locked stages
- Unlock new quests by completing previous ones

## Assets

The app includes pixel art assets for:
- Character doing push-ups
- Character running
- Character jumping
- Isometric gym building

*Assets are located in `assets/images/`*

## State Management

This app uses **Provider** for state management:
- `QuestProvider`: Manages quest data and progress
- `UserProvider`: Manages user stats and currency

## Color Scheme

- Primary Cyan: `#00D9D9`
- Dark Cyan: `#0099CC`
- Card Background: `#006699`
- Accent Orange: `#FF6600`
- Gem Purple: `#9933FF`
- Coin Yellow: `#FFCC00`

## Future Enhancements

- [ ] Social features (leaderboards, friend challenges)
- [ ] shop functionality (purchase power-ups with coins)
- [ ] Achievement system
- [ ] Statistics dashboard
- [ ] Daily streak tracking
- [ ] Push notifications for daily quests

## Credits

Created with ❤️ using Flutter

## License

This project is for educational purposes.
