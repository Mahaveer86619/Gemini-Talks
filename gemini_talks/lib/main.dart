import 'package:flutter/material.dart';
import 'package:gemini_talks/core/themes/theme.dart';
import 'package:gemini_talks/features/landing/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Talks',
      theme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
