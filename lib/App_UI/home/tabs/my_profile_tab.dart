import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/utils/theme_provider.dart';
import 'package:lavaloon_first_task/utils/locale_provider.dart';
import 'package:lavaloon_first_task/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyProfileTab extends StatelessWidget {
  const MyProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final localeProvider = Provider.of<LocaleProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileImage(),
              const SizedBox(height: 20),
              _buildName(),
              const SizedBox(height: 40),
              _buildThemeToggle(context, themeProvider, isDarkMode, loc),
              const SizedBox(height: 16),
              _buildLanguageToggle(context, localeProvider, loc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        border: Border.all(color: AppColors.primary, width: 3),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/ahmed1.jpg',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primary,
              child: const Icon(
                Icons.person,
                size: 80,
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
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isDarkMode,
    AppLocalizations loc,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
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
              const SizedBox(width: 12),
              Text(
                isDarkMode ? loc.darkMode : loc.lightMode,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(
    BuildContext context,
    LocaleProvider localeProvider,
    AppLocalizations loc,
  ) {
    final isArabic = localeProvider.isArabic;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.language, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                loc.language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  localeProvider.setLocale(const Locale('en'));
                },
                child: Text(
                  loc.english,
                  style: TextStyle(
                    color: isArabic
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : AppColors.primary,
                    fontWeight: isArabic ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  localeProvider.setLocale(const Locale('ar'));
                },
                child: Text(
                  loc.arabic,
                  style: TextStyle(
                    color: isArabic
                        ? AppColors.primary
                        : Theme.of(context).textTheme.bodyLarge?.color,
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
