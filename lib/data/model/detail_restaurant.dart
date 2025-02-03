class RestaurantDetailResponse {
  bool error;
  String message;
  RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

final List<RestaurantDetail> restaurants = [
  RestaurantDetail(
    id: "rqdv5juczeskfw1e867",
    name: 'Melting Po',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...',
    city: 'Medan',
    address: 'Jln. Pandeglang no 19',
    pictureId: '14',
    categories: [
      Category(name: 'Italia'),
      Category(name: 'Modern'),
    ],
    menus: Menus(
      foods: [
        Category(name: 'Paket rosemary'),
        Category(name: 'Toastie salmon'),
      ],
      drinks: [
        Category(name: 'Es krim'),
        Category(name: 'Sirup'),
      ],
    ),
    rating: 4.5,
    customerReviews: [
      CustomerReview(
        name: 'Ahmad',
        review: 'Tidak rekomendasi untuk pelajar!',
        date: '13 November 2019',
      ),
      CustomerReview(
        name: 'Doni',
        review: 'Tidak rekomendasi untuk pelajar!',
        date: '13 November 2050',
      ),
    ],
  ),
  RestaurantDetail(
    id: "rqdv5juczeskfw1e8678",
    name: 'Chucks Catle',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...',
    city: 'jakarta Pusat',
    address: 'Jln. Benhil no 19',
    pictureId: '15',
    categories: [
      Category(name: 'Amerika'),
      Category(name: 'Modern'),
    ],
    menus: Menus(
      foods: [
        Category(name: 'Rib Eye'),
        Category(name: 'Toastie salmon'),
      ],
      drinks: [
        Category(name: 'Es krim'),
        Category(name: 'Sirup'),
      ],
    ),
    rating: 4.5,
    customerReviews: [
      CustomerReview(
        name: 'Ahmad',
        review: 'Gokilllll',
        date: '13 November 2019',
      ),
      CustomerReview(
        name: 'Doni',
        review: 'Enak bet',
        date: '13 November 2050',
      ),
    ],
  ),
];

