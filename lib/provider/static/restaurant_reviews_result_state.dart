import 'package:restaurant_app/data/model/detail_restaurant.dart';

sealed class RestaurantReviewsResultState {}

class RestaurantReviewsNoneState extends RestaurantReviewsResultState {}

class RestaurantReviewsLoadingState extends RestaurantReviewsResultState {}

class RestaurantReviewsErrorState extends RestaurantReviewsResultState {
  final String error;

  RestaurantReviewsErrorState(this.error);
}

class RestaurantReviewsResultLoadedState extends RestaurantReviewsResultState {
  final List<CustomerReview> reviews;

  RestaurantReviewsResultLoadedState(this.reviews);
}