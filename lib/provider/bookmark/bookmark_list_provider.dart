part of '../provider_package.dart'; 

class BookmarkListProvider extends ChangeNotifier{
  final List<RestaurantDetail> _bookmarkList = [];

  List<RestaurantDetail> get bookmarkList => _bookmarkList;

  void addBookmark(RestaurantDetail value){
    _bookmarkList.add(value);
    notifyListeners();
  }

  void removeBookmark(RestaurantDetail value){
    _bookmarkList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemBookmark(RestaurantDetail value){
    final restaurantInList = _bookmarkList.where((element) => element.id == value.id);
    return restaurantInList.isNotEmpty;
  }
}