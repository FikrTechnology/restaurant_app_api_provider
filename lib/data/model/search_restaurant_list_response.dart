import 'package:restaurant_app/data/model/restaurant.dart';

class SearchRestaurantListResponse {
  final bool error;
  final int founded;
  final List<RestaurantList> restaurants;

  SearchRestaurantListResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return SearchRestaurantListResponse(
      error: json['error'],
      founded: json['founded'],
      restaurants: json['restaurants'] != null
          ? List<RestaurantList>.from(
              json['restaurants'].map((x) => RestaurantList.fromJson(x)))
          : <RestaurantList>[],
    );
  }
}
