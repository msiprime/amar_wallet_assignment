import 'home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<List<Map<String, dynamic>>> getCardData() async {
    await Future.delayed(const Duration(seconds: 2));
    return cardsDataset;
  }
}

final List<Map<String, dynamic>> cardsDataset = [
  {
    "storeName": "Burger King",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567890",
    "cardType": "Gift Card",
    "imageUrl": "https://i.ibb.co.com/pjBrvhw/burgerking.png",
  },
  {
    "storeName": "Cattelan Italia",
    "storeType": "Furniture",
    "barcodeNumber": "1234567891",
    "cardType": "Loyalty Card",
    "imageUrl": "https://i.ibb.co.com/g9JmybQ/cattelan.png",
  },
  {
    "storeName": "Chipotle",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567892",
    "cardType": "Gift Card",
    "imageUrl": "https://i.ibb.co.com/cr6F2LJ/chipotle.png",
  },
  {
    "storeName": "Domino's Pizza",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567893",
    "cardType": "Loyalty Card",
    "imageUrl": "https://i.ibb.co.com/S07rWtT/dominos.png",
  },
  {
    "storeName": "KFC",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567894",
    "cardType": "Gift Card",
    "imageUrl": "https://i.ibb.co.com/HCwcrXd/kfc.png",
  },
  {
    "storeName": "Molteni & C",
    "storeType": "Furniture",
    "barcodeNumber": "1234567895",
    "cardType": "Loyalty Card",
    "imageUrl": "https://i.ibb.co.com/CQhx9zq/molteni.jpg",
  },
  {
    "storeName": "Papa John's",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567896",
    "cardType": "Gift Card",
    "imageUrl": "https://i.ibb.co.com/y03WxgD/papajohns.jpg",
  },
  {
    "storeName": "Starbucks",
    "storeType": "Coffee Shop",
    "barcodeNumber": "1234567897",
    "cardType": "Loyalty Card",
    "imageUrl": "https://i.ibb.co.com/6PgJJcX/starbucks.png",
  },
  {
    "storeName": "Wendy's",
    "storeType": "Fast Food",
    "barcodeNumber": "1234567898",
    "cardType": "Gift Card",
    "imageUrl": "https://i.ibb.co.com/GcwjVFV/wendys.png",
  },
];
