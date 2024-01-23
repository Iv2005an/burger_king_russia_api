import 'dart:convert';
import 'dart:io';

import 'package:burger_king_russia_api/burger_king_russia_api.dart';
import 'package:test/test.dart';

Future<void> saveJson(String fileName, dynamic data) async {
  final apiResponsesDirectory = Directory('api_responses');
  await apiResponsesDirectory.create();
  File file = File('${apiResponsesDirectory.path}/$fileName.json');
  await file.writeAsString(jsonEncode(data));
}

void main() {
  group('BK', () {
    test('getSystemAb()', () async {
      final data = jsonDecode((await BK.getSystemAb()).data);
      expect(data, isNotEmpty);
      await saveJson('getSystemAb()', data);
    });
    test('getSystemAnalytics()', () async {
      final data = (await BK.getSystemAnalytics()).data;
      expect(data, isNotEmpty);
      await saveJson('getSystemAnalytics()', data);
    });
    test('getSystemConfiguration()', () async {
      final data = (await BK.getSystemConfiguration()).data;
      expect(data, isNotEmpty);
      await saveJson('getSystemConfiguration()', data);
    });

    test('getSbpBanks()', () async {
      final data = (await BK.getSbpBanks()).data;
      expect(data, isNotEmpty);
      await saveJson('getSbpBanks()', data);
    });

    test('getHashFromResponse()', () async {
      final data = BK.getHashFromResponse(await BK.getCatalog());
      expect(data, isNotEmpty);
      await saveJson('getHashFromResponse()', data);
    });

    test('getRestaurants()', () async {
      final data = (await BK.getRestaurants()).data;
      expect(data, isNotEmpty);
      await saveJson('getRestaurants()', data);
    });
    test('getRestaurantsHash()', () async {
      final data = await BK.getRestaurantsHash();
      expect(data, isNotEmpty);
      await saveJson('getRestaurantsHash()', data);
    });

    test('getCatalog()', () async {
      final data = (await BK.getCatalog()).data;
      expect(data, isNotEmpty);
      await saveJson('getCatalog()', data);
    });
    test('getCatalogHash()', () async {
      final data = await BK.getCatalogHash();
      expect(data, isNotEmpty);
      await saveJson('getCatalogHash()', data);
    });

    test('getImageUrl(imageId)', () async {
      final data = await BK.getImageUrl('92e135c02698e6d541e6099d3e58543d');
      expect(data, isNotEmpty);
      await saveJson('getImageUrl(imageId)', data);
    });
    test('getImageUrl(imageId, imageSize, systemConfiguration)', () async {
      final data = await BK.getImageUrl('92e135c02698e6d541e6099d3e58543d',
          imageSize: 1,
          systemConfiguration: (await BK.getSystemConfiguration()).data);
      expect(data, isNotEmpty);
      await saveJson(
          'getImageUrl(imageId, imageSize, systemConfiguration)', data);
    });

    test('getDishes()', () async {
      final data = (await BK.getDishes()).data;
      expect(data, isNotEmpty);
      await saveJson('getDishes()', data);
    });
    test('getDishesHash()', () async {
      final data = await BK.getDishesHash();
      expect(data, isNotEmpty);
      await saveJson('getDishesHash()', data);
    });

    test('getDishOptions(dishId)', () async {
      final data = (await BK.getDishOptions(13735)).data;
      expect(data, isNotEmpty);
      await saveJson('getDishOptions(dishId)', data);
    });
    test('getDishOptions(invalidDishId)', () async {
      expect(() async => await BK.getDishOptions(0), throwsException);
    });

    test('getDishDetails()', () async {
      final data = (await BK.getDishDetails()).data;
      expect(data, isNotEmpty);
      await saveJson('getDishDetails()', data);
    });
    test('getDishDetails(dishId)', () async {
      final data = (await BK.getDishDetails(13735)).data;
      expect(data, isNotEmpty);
      await saveJson('getDishDetails(dishId)', data);
    });

    test('getDishStruct(comboId)', () async {
      final data = (await BK.getDishStruct(11115)).data;
      expect(data, isNotEmpty);
      await saveJson('getDishStruct(comboId)', data);
    });
    test('getDishStruct(comboId, restaurantId)', () async {
      final data = (await BK.getDishStruct(11115, 679)).data;
      expect(data, isNotEmpty);
      await saveJson('getDishStruct(comboId, restaurantId)', data);
    });
    test('getDishStruct(invalidComboId)', () async {
      expect(() async => await BK.getDishStruct(0), throwsException);
    });

    test('getMenu()', () async {
      final data = (await BK.getMenu()).data;
      expect(data, isNotEmpty);
      await saveJson('getMenu()', data);
    });
    test('getMenu(restaurantId)', () async {
      final data = (await BK.getMenu(679)).data;
      expect(data, isNotEmpty);
      await saveJson('getMenu(restaurantId)', data);
    });
    test('getMenu(invalidRestaurantId)', () async {
      expect(() async => await BK.getMenu(1500), throwsException);
    });

    test('getMenuHash()', () async {
      final data = await BK.getMenuHash();
      expect(data, isNotEmpty);
      await saveJson('getMenuHash()', data);
    });
    test('getMenuHash(restaurantId)', () async {
      final data = await BK.getMenuHash(679);
      expect(data, isNotEmpty);
      await saveJson('getMenuHash(restaurantId)', data);
    });
    test('getMenuHash(invalidRestaurantId)', () async {
      expect(() async => await BK.getMenuHash(1500), throwsException);
    });

    test('getStories()', () async {
      final data = (await BK.getStories()).data;
      expect(data, isNotEmpty);
      await saveJson('getStories()', data);
    });

    test('getMobilePromo()', () async {
      final data = (await BK.getMobilePromo()).data;
      expect(data, isNotEmpty);
      await saveJson('getMobilePromo()', data);
    });
    test('getMobilePromo(restaurantId)', () async {
      final data = (await BK.getMobilePromo(679)).data;
      expect(data, isNotEmpty);
      await saveJson('getMobilePromo(restaurantId)', data);
    });

    test('getCoupons()', () async {
      final data = (await BK.getCoupons()).data;
      expect(data, isNotEmpty);
      await saveJson('getCoupons()', data);
    });
    test('getCoupons(restaurantId)', () async {
      final data = (await BK.getCoupons(679)).data;
      expect(data, isNotEmpty);
      await saveJson('getCoupons(restaurantId)', data);
    });

    test('getCouponsHash()', () async {
      final data = await BK.getCouponsHash();
      expect(data, isNotEmpty);
      await saveJson('getCouponsHash()', data);
    });
    test('getCouponsHash(restaurantId)', () async {
      final data = await BK.getCouponsHash(679);
      expect(data, isNotEmpty);
      await saveJson('getCouponsHash(restaurantId)', data);
    });

    test('getEvents()', () async {
      final data = (await BK.getEvents()).data;
      expect(data, isNotEmpty);
      await saveJson('getEvents()', data);
    });

    test('getDeliveryMenu()', () async {
      final data = (await BK.getDeliveryMenu()).data;
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenu()', data);
    });
    test('getDeliveryMenu(latitude, longitude)', () async {
      final data = (await BK.getDeliveryMenu(latitude: 55, longitude: 37)).data;
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenu(latitude, longitude)', data);
    });

    test('getDeliveryMenu()', () async {
      final data = (await BK.getDeliveryMenu()).data;
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenu()', data);
    });
    test('getDeliveryMenu(latitude, longitude)', () async {
      final data = (await BK.getDeliveryMenu(latitude: 55, longitude: 37)).data;
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenu(latitude, longitude)', data);
    });

    test('getDeliveryMenuHash()', () async {
      final data = await BK.getDeliveryMenuHash();
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenuHash()', data);
    });
    test('getDeliveryMenuHash(latitude, longitude)', () async {
      final data = await BK.getDeliveryMenuHash(latitude: 55, longitude: 37);
      expect(data, isNotEmpty);
      await saveJson('getDeliveryMenuHash(latitude, longitude)', data);
    });
  });
}
