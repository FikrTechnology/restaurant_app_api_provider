import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/static/restaurant_reviews_result_state.dart';

class RestaurantDetailReviewsProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantDetailReviewsProvider(this._apiService);

  RestaurantReviewsResultState _resultState = RestaurantReviewsNoneState();
  RestaurantReviewsResultState get resultState => _resultState;

  Future<void> fetchReviews(String id, String name, String review) async {
    try {
      _resultState = RestaurantReviewsLoadingState();
      notifyListeners();
      final result = await _apiService.sendReview(id, name, review);
      if (result.error) {
        _resultState = RestaurantReviewsErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantReviewsResultLoadedState(result.customReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewsErrorState(e.toString());
      notifyListeners();
    }
  }
}