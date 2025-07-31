// models/product.dart
// ignore_for_file: body_might_complete_normally_nullable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  double price;
  String image;
  String productId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.productId = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'productId': productId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data, String docId) {
    return Product(
        id: data['id'],
        name: data['name'],
        price: data['price'].toDouble(),
        image: data['image'],
        productId: docId);
  }
}
