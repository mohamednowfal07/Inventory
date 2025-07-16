


class CartModel {
  String id;
  String name;
  String image;
  double price;
  int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity =1,

  });

  double get totalPrice => price *quantity;
}