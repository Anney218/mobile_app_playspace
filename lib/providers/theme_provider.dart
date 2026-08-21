import 'package:flutter/material.dart';
import '../services/shared_pref_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPrefService _prefService = SharedPrefService();
  bool _isDarkMode = false;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    _isDarkMode = await _prefService.getThemeMode();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    notifyListeners();
    await _prefService.saveThemeMode(isDark);
  }
}
