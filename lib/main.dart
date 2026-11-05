import 'package:flutter/material.dart';
import 'package:flutterbytes_animations/src/screens/home_screen.dart';

void main() {
  runApp(const AnimationWalkthroughApp());
}

class AnimationWalkthroughApp extends StatelessWidget {
  const AnimationWalkthroughApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterbytes Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
