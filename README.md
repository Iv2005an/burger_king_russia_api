API for receiving data from Burger King Russia. The library has a class with static methods for retrieving data.

## Usage

Receive a `dio` response from Burger King Russia with information about restaurants, and outputting the request data to the console:

```dart
import 'package:burger_king_russia_api/burger_king_russia_api.dart';

void main() async {
  final bkRestaurants = await BK.getRestaurants();
  print('bkRestaurants: $bkRestaurants');
}
```

Output of product data:

```dart
import 'package:burger_king_russia_api/burger_king_russia_api.dart';

void main() async {
  final product = (await BK.getDishes()).data['response']['dishes'].first;
  print("""Id: ${product['id']}
Title: ${product['name']}
Image URL: ${await BK.getImageUrl(product['image']['name'])}""");
}

OUTPUT:
Id: 1549
Title: Комикс
Image URL: https://orderapp-static.burgerkingrus.ru/x512/mobile_image/92e135c02698e6d541e6099d3e58543d.png
```