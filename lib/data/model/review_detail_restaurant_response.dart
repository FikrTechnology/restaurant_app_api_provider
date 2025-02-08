import 'package:restaurant_app/data/model/detail_restaurant.dart';

class ReviewDetailRestaurantResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customReviews;

  ReviewDetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.customReviews,
  });

  factory ReviewDetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return ReviewDetailRestaurantResponse(
      error: json['error'],
      message: json['message'],
      customReviews: json['customerReviews'] != null
          ? List<CustomerReview>.from(
              json['customerReviews'].map((x) => CustomerReview.fromJson(x)))
          : <CustomerReview>[],
    );
  }
}
