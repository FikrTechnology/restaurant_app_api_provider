part of '../../package.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Restaurant'),
      ),
      body: Consumer<BookmarkListProvider>(
        builder: (context, value, child) {
          final bookMarkList = value.bookmarkList;
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
