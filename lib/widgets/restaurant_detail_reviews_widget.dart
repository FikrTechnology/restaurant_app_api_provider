part of 'widgets_package.dart';

class DetailReviewsWidget extends StatelessWidget {
  // final RestaurantDetail restaurant;
  const DetailReviewsWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(builder: (context, value, child) {
      return switch (value.resultState) {
        RestaurantDetailLoadingState() =>
          const Center(child: CircularProgressIndicator()),
        RestaurantDetailErrorState(error: var error) =>
          Center(child: Text(error)),
        RestaurantDetailResultLoadedState(data: var restaurant) =>
          _buildReviews(context, restaurant),
        _ => const SizedBox(),
      };
    });
  }

  Widget _buildReviews(BuildContext context, RestaurantDetail restaurant) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Reviews", style: Theme.of(context).textTheme.titleMedium),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: restaurant.customerReviews
                  .map((review) => Card(
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(review.review),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
