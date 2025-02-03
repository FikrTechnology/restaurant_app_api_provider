part of '../../package.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<RestaurantDetail> _completerRestaurant =
      Completer<RestaurantDetail>();
  late Future<RestaurantDetailResponse> _futureRestaurantDetail;

  @override
  void initState() {
    super.initState();
    _loadRestaurantDetail();
  }

  void _loadRestaurantDetail() {
    setState(() {
      _futureRestaurantDetail =
          ApiService().getRestaurantDetail(widget.restaurantId.toString());
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
            child: FutureBuilder(
                future: _completerRestaurant.future,
                builder: (context, snapshot) {
                  return switch (snapshot.connectionState) {
                    ConnectionState.done => BookmarkIcon(restaurant: snapshot.data!),
                    _ => const SizedBox(),
                  };
                },
              ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureRestaurantDetail,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()));
              }

              final restaurantDetailData = snapshot.data!.restaurant;
              _completerRestaurant.complete(restaurantDetailData);
              return BodyDetailScreenWidget(restaurant: restaurantDetailData, onReviewSubmitted: _loadRestaurantDetail,);
            default:
              return const SizedBox();
          }
        }
      ),
    );
  }
}
