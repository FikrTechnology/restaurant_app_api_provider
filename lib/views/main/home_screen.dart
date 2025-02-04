part of '../../package.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<RestaurantListResponse> _futureRestaurantListResponse;

  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  List<RestaurantList> _searchResults = [];

  @override
  void initState() {
    super.initState();
    // _futureRestaurantListResponse = ApiService().getRestaurantList();

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
        _searchRestaurants(_searchController.text);
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  Future<void> _searchRestaurants(String query) async {
    try {
      final response = await ApiService().searchRestaurants(query);
      setState(() {
        _searchResults = response.restaurants;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
      });
    }
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
              child: _searchResults.isNotEmpty
                  ? RestaurantGridListCardWidget(
                      restaurants: _searchResults,
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
                            Center(
                              child: Text(message),
                            ),
                          _ => const SizedBox()
                        };
                      },
                    )
              // : FutureBuilder<RestaurantListResponse>(
              //     future: _futureRestaurantListResponse,
              //     builder: (context, snapshot) {
              //       switch (snapshot.connectionState) {
              //         case ConnectionState.none:
              //         case ConnectionState.waiting:
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         case ConnectionState.active:
              //         case ConnectionState.done:
              //           if (snapshot.hasError) {
              //             return Center(
              //               child: Text(snapshot.error.toString()),
              //             );
              //           }
              //           return RestaurantGridListCardWidget(
              //             restaurants: snapshot.data!.restaurants,
              //           );
              //         default:
              //           return const SizedBox();
              //       }
              //     },
              //   ),
              ),
        ],
      ),
    );
  }
}
