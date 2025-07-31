class CartItem {
  String id;
  String name;
  String image;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  double get totalPrice => price * quantity;
}
