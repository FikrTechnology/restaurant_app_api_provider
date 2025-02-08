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
    final bookmarkedListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(
      () {
        final restaurantInList =
            bookmarkedListProvider.checkItemBookmark(widget.restaurant);
        bookmarkIconProvider.isBookmarked = restaurantInList;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final bookmarkedListProvider = context.read<BookmarkListProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;
        if (!isBookmarked) {
          bookmarkedListProvider.addBookmark(widget.restaurant);
        } else {
          bookmarkedListProvider.removeBookmark(widget.restaurant);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
