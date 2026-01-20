import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lavaloon_first_task/app_ui/onboarding/onbording_screen.dart';
import 'package:lavaloon_first_task/app_ui/home/home_screen.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/auth/sgin_up.dart';
import 'package:lavaloon_first_task/auth/reset_password.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'lib/l10n',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final isArabic = context.locale.languageCode == 'ar';
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // --- Localization Config ---
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            // --- Theme Config ---
            theme: AppTheme.light(isArabic),
            darkTheme: AppTheme.dark(isArabic),
            themeMode: themeProvider.themeMode,

            // --- Routes ---
            initialRoute: OnboardingScreen.routName,
            routes: {
              OnboardingScreen.routName: (context) => const OnboardingScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              SignUpScreen.routeName: (context) => const SignUpScreen(),
              ResetPasswordScreen.routeName: (context) =>
                  const ResetPasswordScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
