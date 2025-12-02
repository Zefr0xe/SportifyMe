import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quest_provider.dart';
import 'providers/user_provider.dart';
import 'utils/colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'SportifyMe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: AppColors.primaryCyan,
          fontFamily: 'sans-serif',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
