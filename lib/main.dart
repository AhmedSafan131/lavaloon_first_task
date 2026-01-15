import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lavaloon_first_task/App_UI/onboarding/onbording_screen.dart';
import 'package:lavaloon_first_task/App_UI/home/home_screen.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/auth/sgin_up.dart';
import 'package:lavaloon_first_task/auth/reset_password.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.whiteColor,
              cardColor: AppColors.whiteColor,
              primaryColor: AppColors.primary,
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                surface: AppColors.whiteColor,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.primaryDark,
              cardColor: AppColors.primaryDark,
              primaryColor: AppColors.primary,
              colorScheme: ColorScheme.dark(
                primary: AppColors.primary,
                surface: AppColors.primaryDark,
              ),
            ),
            themeMode: themeProvider.themeMode,
            initialRoute: '/onboarding',
            routes: {
              '/onboarding': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/reset-password': (context) => const ResetPasswordScreen(),
              '/home': (context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
