import 'dart:convert';

class Product {
  String productName;
  double price;
  DateTime createdAt;
  Map<DateTime, double> priceHistory;
  Product({
    required this.productName,
    required this.price,
    required this.createdAt,
    required this.priceHistory
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'],
      price: map['price'],
      createdAt: DateTime.parse(map['createdAt']),
      priceHistory: //{}
        map['priceHistory'] == {} ? <DateTime, double>{} : Map.from(jsonDecode(map['priceHistory'])).map((key, value) {
          return MapEntry(DateTime.parse(key.toString()), double.parse(value.toString()));
        }),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'priceHistory': jsonEncode(priceHistory.map((key, value) {
        return MapEntry(key.toIso8601String(), value);
        }
      ))
    };
  }
}