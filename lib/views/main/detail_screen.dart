part of '../../package.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
    _loadRestaurantDetail();
  }

  void _loadRestaurantDetail() {
    setState(() {
      Future.microtask(() {
        context
            .read<RestaurantDetailProvider>()
            .fetchRestaurantDetail(widget.restaurantId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailResultLoadedState(data: var restaurant) =>
                    BookmarkIcon(restaurant: restaurant),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(child: CircularProgressIndicator()),
            RestaurantDetailErrorState(error: var error) => ErrorDisplayWidget(
              message: error, 
              onRetry: () => context.read<RestaurantListProvider>().fetchRestaurantList(),
            ),
            RestaurantDetailResultLoadedState(data: var restaurant) => BodyDetailScreenWidget(
              restaurant: restaurant,
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
