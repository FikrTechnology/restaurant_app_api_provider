import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);
}

class RestaurantListResultLoadedState extends RestaurantListResultState {
  final List<RestaurantList> data;

  RestaurantListResultLoadedState(this.data);
}
