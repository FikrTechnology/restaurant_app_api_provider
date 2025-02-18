import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/provider_package.dart';
import 'package:restaurant_app/provider/static/restaurant_list_result_state.dart';

class MockClient extends Mock implements http.Client {}

class MockRestaurantServices extends Mock implements ApiService {}

void main() {
  late MockRestaurantServices mockRestaurantServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockRestaurantServices = MockRestaurantServices();
    restaurantListProvider = RestaurantListProvider(mockRestaurantServices);
  });

  group('RestaurantListProvider', () {
    test('RestaurantListNoneState',
        () {
      final initState = restaurantListProvider.resultState;

      expect(initState, isA<RestaurantListNoneState>());
    });

    test(
        ' RestaurantListLoadingState',
        () async {
      when(() => mockRestaurantServices.getRestaurantList())
          .thenAnswer((_) async => RestaurantListResponse(
                error: false,
                message: 'success',
                count: 1,
                restaurants: [
                  RestaurantList(
                    id: '1',
                    name: 'Test Restaurant',
                    description: 'Description',
                    pictureId: '1',
                    city: 'Test City',
                    rating: 4.5,
                  ),
                ],
              ));

      final future = restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState,
          isA<RestaurantListLoadingState>());

      await future;
    });
    test('RestaurantListLoadedState', () async {
      when(() => mockRestaurantServices.getRestaurantList())
          .thenAnswer((_) async => RestaurantListResponse(
                error: false,
                message: 'success',
                count: 1,
                restaurants: [
                  RestaurantList(
                    id: '1',
                    name: 'Test Restaurant',
                    description: 'Description',
                    pictureId: '1',
                    city: 'Test City',
                    rating: 4.5,
                  ),
                ],
              ));

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListResultLoadedState>());
      final state =
          restaurantListProvider.resultState as RestaurantListResultLoadedState;
      expect(state.data.first.name, 'Test Restaurant');
    });

    test('RestaurantListFailureState', () async {
      when(() => mockRestaurantServices.getRestaurantList())
          .thenThrow(Exception('Failed to load restaurant list'));

      await restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState,
          isA<RestaurantListErrorState>());
      final state =
          restaurantListProvider.resultState as RestaurantListErrorState;
      expect(state.error, contains('Failed to load restaurant list'));
    });
  });
}