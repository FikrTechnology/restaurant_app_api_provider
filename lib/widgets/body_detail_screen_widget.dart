part of 'widgets_package.dart';

class BodyDetailScreenWidget extends StatelessWidget {
  final RestaurantDetail restaurant;

  const BodyDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: restaurant.pictureId,
            child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}"),
          ),
          DetailNameCard(restaurant: restaurant),
          DetailDescriptionCard(restaurant: restaurant),
          DetailMenuWidget(restaurant: restaurant),
          const DetailReviewsWidget(),
          ReviewForm(
            restaurant: restaurant,
          ),
        ],
      ),
    );
  }
}
