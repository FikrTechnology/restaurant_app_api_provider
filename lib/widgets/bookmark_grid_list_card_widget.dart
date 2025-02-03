part of 'widgets_package.dart';


class BookmarkGridListCardWidget extends StatelessWidget {
  final List<RestaurantDetail> restaurants;

  const BookmarkGridListCardWidget({
    super.key, 
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final RestaurantDetail restaurant = restaurants[index];
        return BookmarkRestaurantListCard(
          restaurant: restaurant,
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationRoute.detailRoute.name,
              arguments: restaurant.id,
            );
          },
        );
      },
    );
  }
}