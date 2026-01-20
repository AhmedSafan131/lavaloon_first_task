import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  static const String _prefsKey = 'themeMode';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_prefsKey);
    final AppThemeMode mode = _parseAppThemeMode(value);
    _themeMode = _toThemeMode(mode);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final AppThemeMode appMode = _toAppThemeMode(mode);
    await prefs.setString(_prefsKey, appMode.name);
  }

  AppThemeMode _parseAppThemeMode(String? value) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeMode.light,
    );
  }

  AppThemeMode _toAppThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }

  ThemeMode _toThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
