import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:provider/provider.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/app_assets.dart';
import 'package:lavaloon_first_task/models/onboarding_model.dart';
import 'package:lavaloon_first_task/widgets/onboarding_controls.dart';
import 'package:lavaloon_first_task/utils/theme_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScreen.routeName);
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
    return ResponsiveBuilder(
      builder: (context, sizing) {
        final isDesktop = sizing.deviceScreenType == DeviceScreenType.desktop;
        final isTablet = sizing.deviceScreenType == DeviceScreenType.tablet;
        final horizontalPadding = isDesktop ? 64.0 : isTablet ? 40.0 : 24.0;
        final imageHeight = isDesktop ? 360.0 : isTablet ? 300.0 : 240.0;
        final content = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(model.image, height: imageHeight.h, fit: BoxFit.contain),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (i) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == currentPage ? AppColors.primary : Colors.grey[300],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              model.titleKey.trn,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              model.descriptionKey.trn,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        );
        if (isDesktop || isTablet) {
          return Padding(
            padding: EdgeInsets.all(horizontalPadding.w),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      model.image,
                      height: imageHeight.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 32.w),
                Expanded(child: content),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(horizontalPadding.w),
          child: content,
        );
      },
    );
  }
}
