import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 1. Add these imports for localization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lavaloon_first_task/l10n/app_localizations.dart';
import 'package:lavaloon_first_task/App_UI/onboarding/onbording_screen.dart';
import 'package:lavaloon_first_task/App_UI/home/home_screen.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/auth/sgin_up.dart';
import 'package:lavaloon_first_task/auth/reset_password.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/utils/locale_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()), // Added this
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        // Using Consumer2 for both
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // --- Localization Config ---
            locale: localeProvider.locale, // Set current language
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // --- Theme Config ---
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
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary,
                elevation: 0,
                centerTitle: localeProvider.isArabic,
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
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary,
                elevation: 0,
                centerTitle: localeProvider.isArabic,
              ),
            ),
            themeMode: themeProvider.themeMode,

            // --- Routes ---
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
