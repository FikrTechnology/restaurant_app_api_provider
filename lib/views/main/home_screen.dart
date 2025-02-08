part of '../../package.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.length >= 3) {
        context
            .read<RestaurantSearchListProvider>()
            .fetchSearchRestaurantList(_searchController.text);
      } else {
        context.read<RestaurantSearchListProvider>().clearRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                labelText: 'Cari Restaurant',
                labelStyle: TextStyle(color: Colors.cyan),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) => _onSearchChanged(),
            ),
          ),
          Expanded(
              child: _searchController.text.isNotEmpty
                  ? Consumer<RestaurantSearchListProvider>(
                      builder: (context, value, child) {
                        return switch (value.resultState) {
                          RestaurantSearchLoadingState() => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          RestaurantSearchResultLoadedState(
                            data: var restaurants
                          ) =>
                            RestaurantGridListCardWidget(
                              restaurants: restaurants,
                            ),
                          RestaurantSearchErrorState(error: var message) =>
                            ErrorDisplayWidget(
                              message: message,
                              onRetry: () => context
                                  .read<RestaurantListProvider>()
                                  .fetchRestaurantList(),
                            ),
                          _ => const SizedBox()
                        };
                      },
                    )
                  : Consumer<RestaurantListProvider>(
                      builder: (context, value, child) {
                        return switch (value.resultState) {
                          RestaurantListLoadingState() => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          RestaurantListResultLoadedState(
                            data: var restaurants
                          ) =>
                            RestaurantGridListCardWidget(
                              restaurants: restaurants,
                            ),
                          RestaurantListErrorState(error: var message) =>
                            ErrorDisplayWidget(
                              message: message,
                              onRetry: () => context
                                  .read<RestaurantListProvider>()
                                  .fetchRestaurantList(),
                            ),
                          _ => const SizedBox()
                        };
                      },
                    )),
        ],
      ),
    );
  }
}
