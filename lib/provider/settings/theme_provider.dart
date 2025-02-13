part of '../provider_package.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = "isDarkModeOn";
  bool _isDarkModeOn = false;

  bool get isDarkModeOn => _isDarkModeOn;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkModeOn = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkModeOn = !_isDarkModeOn;
    await prefs.setBool(_themeKey, _isDarkModeOn);
    notifyListeners();
  }
}
