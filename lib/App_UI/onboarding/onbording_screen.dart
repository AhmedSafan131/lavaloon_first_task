import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';

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
      image: 'assets/images/splash1.png',
      titleKey: 'onboarding1_title',
      descriptionKey: 'onboarding1_desc',
    ),
    OnboardingModel(
      image: 'assets/images/splash2.png',
      titleKey: 'onboarding2_title',
      descriptionKey: 'onboarding2_desc',
    ),
    OnboardingModel(
      image: 'assets/images/splash3.png',
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
            _buildControls(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    final isLast = _currentPage == _onboardingData.length - 1;
    final isFirst = _currentPage == 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirst)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'back'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          else
            const SizedBox(width: 80),
          ElevatedButton(
            onPressed: () {
              if (!isLast) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScreen.routeName);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 44),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: AppColors.primary),
              ),
            ),
            child: Text(isLast ? 'done'.tr() : 'next'.tr()),
          ),
        ],
      ),
    );
  }
}

class OnboardingModel {
  final String image;
  final String titleKey;
  final String descriptionKey;

  const OnboardingModel({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
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
