part of 'widgets_package.dart';

class DetailDescriptionCard extends StatelessWidget {
  final RestaurantDetail restaurant;
  const DetailDescriptionCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Categories",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: restaurant.categories
                      .map((category) => Chip(label: Text(category.name)))
                      .toList(),
                ),
                const SizedBox(height: 15),
                Text("Description",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Text(restaurant.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
