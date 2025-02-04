import 'package:restaurant_app/data/model/detail_restaurant.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailResultLoadedState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailResultLoadedState(this.data);
}