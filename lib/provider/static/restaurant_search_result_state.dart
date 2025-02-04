import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
}

class RestaurantSearchResultLoadedState extends RestaurantSearchResultState {
  final List<RestaurantList> data;

  RestaurantSearchResultLoadedState(this.data);
}