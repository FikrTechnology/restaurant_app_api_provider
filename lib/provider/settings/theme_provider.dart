part of '../provider_package.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = "isDarkModeOn";
  static const String _themeModeLightKey = "themeModeLight";

  bool _isDarkModeOn = false;
  bool _isLightModeOn = false;

  bool get isDarkModeOn => _isDarkModeOn;
  bool get isLightModeOn => _isLightModeOn;

  ThemeProvider() {
    _loadTheme();
    _loadLightTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkModeOn = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkModeOn = !_isDarkModeOn;
    _isLightModeOn = false;
    await prefs.setBool(_themeKey, _isDarkModeOn);
    notifyListeners();
  }

  void _loadLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isLightModeOn = prefs.getBool(_themeModeLightKey) ?? false;
    notifyListeners();
  }

  void toggleLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isLightModeOn = !_isLightModeOn;
    _isDarkModeOn = false;
    await prefs.setBool(_themeModeLightKey, _isLightModeOn);
    notifyListeners();
  }
}
