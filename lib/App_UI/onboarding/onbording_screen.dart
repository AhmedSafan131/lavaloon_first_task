import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/app_assets.dart';
import 'package:lavaloon_first_task/models/onboarding_model.dart';
import 'package:lavaloon_first_task/widgets/onboarding_controls.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _onboardingData = [
    OnboardingModel(
      image: AppAssets.onboarding1,
      titleKey: 'onboarding1_title',
      descriptionKey: 'onboarding1_desc',
    ),
    OnboardingModel(
      image: AppAssets.onboarding2,
      titleKey: 'onboarding2_title',
      descriptionKey: 'onboarding2_desc',
    ),
    OnboardingModel(
      image: AppAssets.onboarding3,
      titleKey: 'onboarding3_title',
      descriptionKey: 'onboarding3_desc',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    themeProvider.setThemeMode(
                      isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  icon: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    model: _onboardingData[index],
                    currentPage: _currentPage,
                    totalPages: _onboardingData.length,
                  );
                },
              ),
            ),
            OnboardingControls(
              controller: _pageController,
              isFirst: _currentPage == 0,
              isLast: _currentPage == _onboardingData.length - 1,
              onDone: () {
                Navigator.of(context).pushReplacementNamed(
                  LoginScreen.routeName,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final int currentPage;
  final int totalPages;
  const OnboardingPage({
    Key? key,
    required this.model,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(model.image, height: 240, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == currentPage
                      ? AppColors.primary
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            model.titleKey.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            model.descriptionKey.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
