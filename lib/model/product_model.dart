// models/product.dart
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

  factory Product.fromMap(Map<String, dynamic> data, String docId) {
    return Product(
        id: data['id'],
        name: data['name'],
        price: data['price'].todouble(),
        image: data['image'],
        productId: docId);
  }

  data() {}
}
