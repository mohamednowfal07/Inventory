// ignore_for_file: annotate_overrides, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/cart_screen.dart';
import 'package:inventory_project/main.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
import 'package:inventory_project/productdetails_screen.dart';
import 'package:inventory_project/screens/add_edit_screen.dart';
import 'package:inventory_project/screens/animated_inventory_screen.dart';
import 'package:inventory_project/screens/explicit_animation_screen.dart';
import 'package:inventory_project/screens/hero_animation_screen.dart';
import 'package:inventory_project/servives/product_services.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  late Future<List<Product>> _product;
  @override
  void initState() {
    super.initState();
    _product = FirestoreServices().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: const Color.fromARGB(255, 0, 0, 0)),
              child: Text(
                'Nowfal',
                style: TextStyle(fontSize: 24, color: Colors.indigo),
              ),
            ),
            ListTile(
              leading: Icon(Icons.animation),
              title: Text('Animation'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImplicitAnimationsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.animation),
              title: Text('Explicit Animation'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExplicitAnimationScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.animation),
              title: Text('Hero Animation'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HeroAnimationScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Products List",
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEditScreen()));
              },
              icon: Icon(Icons.add)),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 10,
                  child: Text(
                    cart.cartItems.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: FutureBuilder(
          future: _product,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print(snapshot);
              return Center(child: Text("Data has some error"));
            }
            final product = snapshot.data;
            print(product);
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: product!.length,
              itemBuilder: (context, index) {
                final products = product[index];
                return GestureDetector(
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddEditScreen(product: products)));
                  },
                  child: Column(children: [
                    CircleAvatar(backgroundImage: AssetImage(products.image)),
                    Text(products.name),
                    Text(products.price.toString()),
                    ElevatedButton(
                      onPressed: () {
                        cart.addToCart(products);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("${products.name} added to cart screen"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text("Add To Cart"),
                    ),
                  ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
