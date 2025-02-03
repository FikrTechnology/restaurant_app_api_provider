part of '../provider_package.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavBar => _indexBottomNavBar;

  set indexBottomNavBar(int value) {
    _indexBottomNavBar = value;
    notifyListeners();
  }
}
