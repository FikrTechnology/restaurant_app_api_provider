import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
  });

  group('RestaurantServices', () {
    late ApiService restaurantServices;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      restaurantServices = ApiService();
    });

    test('Get Success Restaurant', () async {
      const sampleResponse = '''{
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
            {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                "pictureId": "14",
                "city": "Medan",
                "rating": 4.2
            },
            {
                "id": "s1knt6za9kkfw1e867",
                "name": "Kafe Kita",
                "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                "pictureId": "25",
                "city": "Gorontalo",
                "rating": 4
            }
        ]
      }''';

      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response(sampleResponse, 200));

      final response = await restaurantServices.getRestaurantList();

      expect(response, isA<RestaurantListResponse>());
      expect(response.restaurants.first.name, "Melting Pot");
    });
  });
}
