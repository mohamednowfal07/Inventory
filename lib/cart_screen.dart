// ignore_for_file: unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/main.dart';
import 'package:inventory_project/model/cart_model.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
import 'package:inventory_project/screens/product_listscreen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void placeOrder() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<CartItem> cartItems = [];
    double totalAmount =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    try {
      await firestore.collection('Cart').add({
        'title': 'jersey',
        'image': 'assets/images/jersey.jpg',
        'totalAmount': '800',
        'id': '1',
        'items': cartItems.map((item) => item.toMap()).toList(),
      });
      await firestore.collection('Cart').add({
        'title': 'watch',
        'image': 'assets/images/watch.jpg',
        'totalAmount': '2000',
        'id': '2',
        'items': cartItems.map((item) => item.toMap()).toList(),
      });
      await firestore.collection('Cart').add({
        'title': 'iphone',
        'image': 'assets/images/iphone.jpg',
        'totalAmount': '200000',
        'id': '3',
        'items': cartItems.map((item) => item.toMap()).toList(),
      });

      // Clear cart or show success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
    } catch (e) {
      print('Error placing order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.cartItems.values.toList();
    print(items);
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                cart.clearCart();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListScreen()));
              },
            )
          ],
        ),
        body: items.isEmpty
            ? Center(
                child: Text("Cart is empty"),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(item.image),
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                item.price.toString(),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "totalPrice:${item.totalPrice}",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(item.quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      cart.addToCart(
                                        Product(
                                            id: item.id,
                                            name: item.name,
                                            price: item.price,
                                            image: item.image),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                  Container(
                    margin: EdgeInsets.all(60),
                  ),
                  ElevatedButton(
                    onPressed: placeOrder,
                    child: Text('PlaceOrder'),
                  ),
                  Text("TotalPrice:${cart.totalPrice}"),
                ],
              ));
  }
}
