part of 'widgets_package.dart';

class DetailMenuWidget extends StatelessWidget {
  final RestaurantDetail restaurant;
  const DetailMenuWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Menu",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Foods",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              children: restaurant.menus.foods
                  .map((food) => Chip(label: Text(food.name)))
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Drinks", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              children: restaurant.menus.drinks
                  .map((drink) => Chip(label: Text(drink.name)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
