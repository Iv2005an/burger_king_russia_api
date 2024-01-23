import 'package:burger_king_russia_api/burger_king_russia_api.dart';

void main() async {
  final product = (await BK.getDishes()).data['response']['dishes'].first;
  print("""Id: ${product['id']}
Title: ${product['name']}
Image URL: ${await BK.getImageUrl(product['image']['name'])}""");
}
