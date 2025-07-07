// screens/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:inventory_project/cart_screen.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
        id: 'p1',
        name: 'iphone',
        price: 30000,
        image: 'assets/images/iphone.jpg'),
    Product(
        id: 'p2', name: 'watch', price: 799, image: 'assets/images/watch.jpg'),
    Product(
        id: 'p2',
        name: 'jersey',
        price: 699,
        image: 'assets/images/jersey.jpg'),
    Product(
        id: 'p2',
        name: 'hoodie',
        price: 699,
        image: 'assets/images/hoodie.jpg'),
    Product(
        id: 'p2', name: 'shoes', price: 599, image: 'assets/images/shoes.jpg'),
    Product(
        id: 'p2', name: 'shirt', price: 699, image: 'assets/images/shirt.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                cart.addToCart(product);
              },
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network(
                      product.image,
                      width: 100,
                      height: 100,
                    ),
                    title: Text(product.name),
                    subtitle: Text('/${product.price.toString()}'),
                    onTap: () {
                      cart.addToCart(product);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
