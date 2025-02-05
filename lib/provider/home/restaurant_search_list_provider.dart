import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/static/restaurant_search_result_state.dart';

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
