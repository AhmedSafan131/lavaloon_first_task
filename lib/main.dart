import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lavaloon_first_task/app_ui/onboarding/onbording_screen.dart';
import 'package:lavaloon_first_task/app_ui/home/home_screen.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/auth/sgin_up.dart';
import 'package:lavaloon_first_task/auth/reset_password.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/apprunnener/app_runner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await runApplication(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final isArabic = context.locale.languageCode == 'ar';
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
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
                    centerTitle: isArabic,
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
                    centerTitle: isArabic,
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
      },
    );
  }
}
