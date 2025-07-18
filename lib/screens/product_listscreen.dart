import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/cart_screen.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
import 'package:inventory_project/screens/add_edit_screen.dart';
import 'package:inventory_project/servives/product_services.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  late Future<List<Product>> _product;
  void initState() {
    super.initState();
    _product = FirestoreServices().fetchProduct();
  }

  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List"),
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
              return Center(child: Text("Data has some error"));
            }
            final product = snapshot.data;

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
