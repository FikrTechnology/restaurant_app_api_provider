part of 'widgets_package.dart';

class RestaurantGridListCardWidget extends StatelessWidget {
  final List<RestaurantList> restaurants;

  const RestaurantGridListCardWidget({
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
        final RestaurantList restaurant = restaurants[index];
        return RestaurantListCard(
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
