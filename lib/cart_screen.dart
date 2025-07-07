// ignore_for_file: unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:inventory_project/main.dart';
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
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.cartItems.values.toList();

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
                              trailing: IconButton(
                                  onPressed: () {
                                    cart.removeFromCart(item.id);
                                  },
                                  icon: Icon(Icons.delete)),
                            );
                          })),
                  Container(
                    margin: EdgeInsets.all(60),
                  ),
                  Text("TotalPrice:${cart.totalprice}"),
                ],
              ));
  }
}
