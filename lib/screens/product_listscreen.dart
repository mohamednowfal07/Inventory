// // ignore_for_file: annotate_overrides, unnecessary_string_interpolations, prefer_const_constructors_in_immutables

// import 'package:flutter/material.dart';
// import 'package:inventory_project/cart_screen.dart';
// import 'package:inventory_project/model/product_model.dart';
// import 'package:inventory_project/model/provider/cart_provider.dart';
// import 'package:inventory_project/servives/product_services.dart';
// import 'package:provider/provider.dart';

// class ProductListScreen extends StatefulWidget {
//   ProductListScreen({super.key});

//   @override
//   State<ProductListScreen> createState() => _ProductListScreen();
// }

// class _ProductListScreen extends State<ProductListScreen> {
//   late Future<List<Product>> _product;
//   void initState() {
//     super.initState();
//     _product = FirestoreServices().fetchProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//         actions: [
//           Stack(children: [
//             IconButton(
//               icon: Icon(Icons.shopping_cart),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CartScreen(),
//                     ));
//               },
//             ),
//             Positioned(
//                 top: 2,
//                 right: 2,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.blueGrey,
//                   radius: 10,
//                   child: Text(
//                     cart.cartItems.length.toString(),
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//                 ),
//           ])
//         ],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(8.0),
//         child: FutureBuilder(
//             future: _product,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting);
//               // // return Center(
//               // //   child: CircularProgressIndicator(),
//               // // );
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Error"),
//                 );
//               }
//               final product = snapshot.data;

// ignore_for_file: unnecessary_cast, curly_braces_in_flow_control_structures, dead_code, use_key_in_widget_constructors, unused_field, annotate_overrides, prefer_const_constructors_in_immutables

//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//                 itemCount: product!.length,
//                 itemBuilder: (context, index) {
//                   final products = product[index];
//                   return Column(
//                     children: [
//                       CircleAvatar(backgroundImage: AssetImage(products.image),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               leading: Image.network(
//                                 products.image,
//                                 width: 50,
//                                 height: 50,
//                               ),
//                               title: Text(products.name),
//                               subtitle:
//                                   Text('${products.price.toStringAsFixed(0)}'),
//                               onTap: () {
//                                 cart.addToCart(products);
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     cart.addToCart(product as Product);
//                                   },
//                                   child: Text("Add to Cart"),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//             ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/cart_screen.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
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
        title: Text("ProductList"),
        backgroundColor: Colors.brown,
        actions: [
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: Image.network(product['image'], width: 50),
                title: Text(product['name']),
                subtitle: Text("₹${product['price']}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    cart.addToCart(products as Product);
                  },
                  child: Text("Add To Cart"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
