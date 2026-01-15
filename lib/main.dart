import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/App_UI/onboarding/onbording_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        // '/login': (context) => const LoginScreen(),
        // '/home': (context) => const HomeScreen(),
      },
    );
  }
}
