part of 'widgets_package.dart';

class BookmarkIcon extends StatefulWidget {
  final RestaurantDetail restaurant;

  const BookmarkIcon({
    super.key,
    required this.restaurant,
  });

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  @override
  void initState() {
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(
      () async {
        await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
        final value =
            localDatabaseProvider.checkItemBookmarked(widget.restaurant.id);

        bookmarkIconProvider.isBookmarked = value;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        RestaurantList restaurant = RestaurantList(
          id: widget.restaurant.id,
          name: widget.restaurant.name,
          description: widget.restaurant.description,
          pictureId: widget.restaurant.pictureId,
          city: widget.restaurant.city,
          rating: widget.restaurant.rating,
        );

        if (!isBookmarked) {
          await localDatabaseProvider.saveRestaurant(restaurant);
        } else {
          await localDatabaseProvider.removeRestoranById(widget.restaurant.id);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
        localDatabaseProvider.loadAllRestaurant();
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
