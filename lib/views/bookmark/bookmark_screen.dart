part of '../../package.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Restaurant'),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookMarkList = value.restaurantList ?? [];
          return switch (bookMarkList.isNotEmpty) {
            true => Center(
                child: BookmarkGridListCardWidget(
                  restaurants: bookMarkList,
                ),
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Bookmarked"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
