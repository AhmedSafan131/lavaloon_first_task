import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lavaloon_first_task/utils/theme_extensions.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:lavaloon_first_task/utils/app_assets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileTab extends StatelessWidget {
  const MyProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final isArabic = context.locale.languageCode == 'ar';

    return SafeArea(
      child: ResponsiveBuilder(
        builder: (context, sizing) {
          final isDesktop = sizing.deviceScreenType == DeviceScreenType.desktop;
          final isTablet = sizing.deviceScreenType == DeviceScreenType.tablet;
          final horizontalPadding = isDesktop
              ? 64.0
              : isTablet
              ? 40.0
              : 24.0;
          final maxWidth = isDesktop
              ? 900.0
              : isTablet
              ? 700.0
              : 500.0;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(horizontalPadding.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    _buildProfileImage(),
                    SizedBox(height: 20.h),
                    _buildName(),
                    SizedBox(height: 40.h),
                    _buildThemeToggle(context, themeProvider, isDarkMode),
                    SizedBox(height: 16.h),
                    _buildLanguageToggle(context, isArabic),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        border: Border.all(color: AppColors.primary, width: 3.w),
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.profileImage,
          width: 120.w,
          height: 120.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primary,
              child: Icon(
                Icons.person,
                size: 80.w,
                color: AppColors.whiteColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      'Ahmed Safan',
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isDarkMode,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: AppColors.primary,
              ),
              SizedBox(width: 12.w),
              Text(
                isDarkMode ? 'darkMode'.trn : 'lightMode'.trn,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: context.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.setThemeMode(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
            thumbColor: MaterialStateProperty.all(AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(BuildContext context, bool isArabic) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.language, color: AppColors.primary),
              SizedBox(width: 12.w),
              Text(
                'language'.trn,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: context.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.setLocale(const Locale('en'));
                },
                child: Text(
                  'english'.trn,
                  style: TextStyle(
                    color: isArabic
                        ? context.textTheme.bodyLarge?.color
                        : AppColors.primary,
                    fontWeight: isArabic ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.setLocale(const Locale('ar'));
                },
                child: Text(
                  'arabic'.trn,
                  style: TextStyle(
                    color: isArabic
                        ? AppColors.primary
                        : context.textTheme.bodyLarge?.color,
                    fontWeight: isArabic ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
