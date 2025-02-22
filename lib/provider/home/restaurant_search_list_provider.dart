part of '../provider_package.dart';

class RestaurantSearchListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantSearchListProvider(
    this._apiService,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  List<RestaurantList> _restaurantList = [];

  List<RestaurantList> get restaurantList => _restaurantList;

  Future<void> fetchSearchRestaurantList(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiService.searchRestaurants(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState(result.error.toString());
        notifyListeners();
      } else {
        _restaurantList = result.restaurants;
        _resultState = RestaurantSearchResultLoadedState(_restaurantList);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }

  void clearRestaurantList() {
    _restaurantList = [];
    _resultState = RestaurantSearchNoneState();
    notifyListeners();
  }
}
