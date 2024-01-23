import 'dart:async';

import 'package:dio/dio.dart';

class BK {
  /// Headers for getting information from Burger King Russia
  static const apiHeaders = {'x-burgerking-platform': 'android'};

  /// URL for getting information about the system analytics from Burger King Russia
  static const systemAnalyticsUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/system/analytics';

  /// URL for getting information about the system configuration from Burger King Russia
  static const systemConfigurationUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/system/configuration';

  /// URL for getting information about the system ab from Burger King Russia
  static const systemAbUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/system/ab';

  /// URL for getting information about sbp banks from Burger King Russia
  static const sbpBanksUrl =
      'https://orderapp.burgerkingrus.ru/api/v3/sbp/banks';

  /// URL for getting information about restaurants from Burger King Russia
  static const restaurantsUrl =
      'https://orderapp.burgerkingrus.ru/api/v3/restaurant/list';

  /// URL for getting information about the catalog from Burger King Russia
  static const catalogUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/catalog';

  /// URL for getting information about dishes from Burger King Russia
  static const dishesUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/dishes';

  /// URL for getting information about dish options from Burger King Russia
  static const dishOptionsUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/dishOptions';

  /// URL for getting information about dish details from Burger King Russia
  static const dishDetailsUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/dishDetails';

  /// URL for getting information about dish struct from Burger King Russia
  static const dishStructUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/dishStruct';

  /// URL for getting information about the menu from Burger King Russia
  static const menuUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/getMenu';

  /// URL for getting information about the delivery menu from Burger King Russia
  static const deliveryMenuUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/delivery/getMenu';

  /// URL for getting information about stories from Burger King Russia
  static const storiesUrl =
      'https://orderapp.burgerkingrus.ru/api/v3/user/stories';

  /// URL for getting information about the mobile promo from Burger King Russia
  static const mobilePromoUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/system/mobilePromo';

  /// URL for getting information about coupons from Burger King Russia
  static const couponsUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/menu/coupons';

  /// URL for getting information about events from Burger King Russia
  static const eventsUrl =
      'https://orderapp.burgerkingrus.ru/api/v1/events/getEvents';

  static final _httpClient = Dio();

  static Map<String, dynamic> _clearNullParameters(
      Map<String, dynamic> parameters) {
    for (var key in parameters.keys.toList()) {
      if (parameters[key] == null) {
        parameters.remove(key);
      }
    }
    return parameters;
  }

  /// Getting information about the system ab from Burger King Russia
  static Future<Response> getSystemAb() async =>
      await _httpClient.get(systemAbUrl, options: Options(headers: apiHeaders));

  /// Getting information about the system analytics from Burger King Russia
  static Future<Response> getSystemAnalytics() async => await _httpClient
      .get(systemAnalyticsUrl, options: Options(headers: apiHeaders));

  /// Getting information about the system configuration from Burger King Russia
  static Future<Response> getSystemConfiguration() async => await _httpClient
      .get(systemConfigurationUrl, options: Options(headers: apiHeaders));

  /// Getting information about sbp banks from Burger King Russia
  static Future<Response> getSbpBanks() async =>
      await _httpClient.get(sbpBanksUrl, options: Options(headers: apiHeaders));

  /// Getting hash code from Burger King Russia response
  ///
  /// [response] is the response to the HEAD request to Burger King Russia
  static String getHashFromResponse(Response response) =>
      response.headers.value('X-Response-Hash') ?? '';

  /// Getting information about restaurants from Burger King Russia
  static Future<Response> getRestaurants() async => await _httpClient
      .get(restaurantsUrl, options: Options(headers: apiHeaders));

  /// Getting information about restaurants hash code from Burger King Russia
  static Future<String> getRestaurantsHash() async =>
      getHashFromResponse(await _httpClient.head(restaurantsUrl,
          options: Options(headers: apiHeaders)));

  /// Getting information about the catalog from Burger King Russia
  static Future<Response> getCatalog() async =>
      await _httpClient.get(catalogUrl, options: Options(headers: apiHeaders));

  /// Getting information about the catalog hash code from Burger King Russia
  static Future<String> getCatalogHash() async =>
      getHashFromResponse(await _httpClient.head(catalogUrl,
          options: Options(headers: apiHeaders)));

  /// Getting URl for GET request to get images from Burger King Russia
  ///
  /// [imageId] is the ID of the dish image from Burger King Russia
  /// [imageSize] can be 0 or 1, 0 is x512, 1 is x256. (0 default)
  static Future<String> getImageUrl(String imageId,
      {int imageSize = 0, Map<String, dynamic>? systemConfiguration}) async {
    if (imageSize < 0 || imageSize > 1) throw Exception('Invalid image size');
    systemConfiguration ??= (await getSystemConfiguration()).data;
    if (systemConfiguration == null) throw Exception('Invalid system config');
    final imageUrlFormat =
        systemConfiguration['response']['IMAGE_URL_FORMAT'].toString();
    const imageSizes = ['512', '256'];
    return imageUrlFormat
        .replaceFirst('{size}', imageSizes[imageSize])
        .replaceFirst('{name}', imageId)
        .replaceFirst('{ext}', 'png');
  }

  /// Getting information about dishes from Burger King Russia
  static Future<Response> getDishes() async =>
      await _httpClient.get(dishesUrl, options: Options(headers: apiHeaders));

  /// Getting information about dishes hash code from Burger King Russia
  static Future<String> getDishesHash() async => getHashFromResponse(
      await _httpClient.head(dishesUrl, options: Options(headers: apiHeaders)));

  /// Getting information about dish options from Burger King Russia
  ///
  /// [dishId] is the ID of the dish from Burger King Russia
  static Future<Response> getDishOptions(int dishId) async => await _httpClient
      .get('$dishOptionsUrl/$dishId', options: Options(headers: apiHeaders));

  /// Getting information about dish details from Burger King Russia
  ///
  /// [dishId] is the ID of the dish from Burger King Russia
  static Future<Response> getDishDetails([int? dishId]) async =>
      await _httpClient.get(dishDetailsUrl,
          options: Options(headers: apiHeaders),
          queryParameters: {'dish': dishId});

  /// Getting information about the dish struct from Burger King Russia
  ///
  /// [comboId] is the ID of the combo from Burger King Russia
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  /// [isDelivery] is the delivery status
  static Future<Response> getDishStruct(
    int comboId, [
    int? restaurantId,
    bool? isDelivery,
  ]) async =>
      await _httpClient.get(dishStructUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters({
            'combo': comboId,
            'restaurant': restaurantId,
            'is_delivery': isDelivery
          }));

  /// Getting information about the menu from Burger King Russia
  ///
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  static Future<Response> getMenu([int? restaurantId]) async =>
      await _httpClient.get(menuUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters({'restaurant': restaurantId}));

  /// Getting information about the menu hash code from Burger King Russia
  ///
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  static Future<String> getMenuHash([
    int? restaurantId,
  ]) async =>
      getHashFromResponse(await _httpClient.head(menuUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters({'restaurant': restaurantId})));

  /// Getting information about stories from Burger King Russia
  static Future<Response> getStories() async =>
      await _httpClient.get(storiesUrl, options: Options(headers: apiHeaders));

  /// Getting information about the mobile promo from Burger King Russia
  ///
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  /// [isDelivery] is the delivery status
  static Future<Response> getMobilePromo([
    int? restaurantId,
    bool? isDelivery,
  ]) async =>
      await _httpClient.get(mobilePromoUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters(
              {'restaurant': restaurantId, 'is_delivery': isDelivery}));

  /// Getting information about coupons from Burger King Russia
  ///
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  /// [isDelivery] is the delivery status
  static Future<Response> getCoupons([
    int? restaurantId,
    bool? isDelivery,
  ]) async =>
      await _httpClient.get(couponsUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters(
              {'restaurant': restaurantId, 'is_delivery': isDelivery}));

  /// Getting information about coupons hash code from Burger King Russia
  ///
  /// [restaurantId] is the ID of the restaurant from Burger King Russia
  /// [isDelivery] is the delivery status
  static Future<String> getCouponsHash([
    int? restaurantId,
    bool? isDelivery,
  ]) async =>
      getHashFromResponse(await _httpClient.head(couponsUrl,
          options: Options(headers: apiHeaders),
          queryParameters: _clearNullParameters(
              {'restaurant': restaurantId, 'is_delivery': isDelivery})));

  /// Getting information about events from Burger King Russia
  static Future<Response> getEvents() async =>
      await _httpClient.get(eventsUrl, options: Options(headers: apiHeaders));

  /// Getting information about the delivery menu from Burger King Russia
  ///
  /// [latitude] is the latitude of the destination
  /// [longitude] is the longitude of the destination
  static Future<Response> getDeliveryMenu({
    double? latitude,
    double? longitude,
  }) async =>
      await _httpClient.get(deliveryMenuUrl,
          options: Options(headers: apiHeaders),
          queryParameters:
              _clearNullParameters({'lat': latitude, 'lon': longitude}));

  /// Getting information about the delivery menu hash code from Burger King Russia
  ///
  /// [latitude] is the latitude of the destination
  /// [longitude] is the longitude of the destination
  static Future<String> getDeliveryMenuHash({
    double? latitude,
    double? longitude,
  }) async =>
      getHashFromResponse(await _httpClient.head(deliveryMenuUrl,
          options: Options(headers: apiHeaders),
          queryParameters:
              _clearNullParameters({'lat': latitude, 'lon': longitude})));
}
