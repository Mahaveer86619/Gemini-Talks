import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_talks/core/themes/theme.dart';
import 'package:gemini_talks/features/gen/view/screens/home_screen.dart';
import 'package:gemini_talks/injection_container.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerServices();
  await dotenv.load(fileName: '.env');
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
