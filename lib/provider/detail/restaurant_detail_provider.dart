import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  RestaurantDetailResultState _reviewState = RestaurantDetailNoneState();
  RestaurantDetailResultState get reviewState => _reviewState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailResultLoadedState(result.restaurant);
        _reviewState =
            RestaurantDetailRewiewsState(result.restaurant.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchReviews(String id, String name, String review) async {
    try {
      _reviewState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.sendReview(id, name, review);
      
      if (result.error) {
        _reviewState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _reviewState = RestaurantDetailRewiewsState(result.customReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _reviewState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
