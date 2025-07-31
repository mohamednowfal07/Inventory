import 'package:flutter/material.dart';
import 'package:inventory_project/productdetails_screen.dart';

class HeroAnimationScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'id': 'p1',
      'title': 'Watch',
      'image': 'assets/images/watch.jpg',
      'description': 'Elegant and sturdy watch for home and office.'
    },
    {
      'id': 'p2',
      'title': 'Sport shoe',
      'image': 'assets/images/Sport shoe.webp',
      'description': 'Stylish Sport shoe .'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (ctx, i) {
          final product = products[i];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => ProductDetailScreen(
                    id: product['id']!,
                    title: product['title']!,
                    imageUrl: product['image']!,
                    description: product['description']!,
                  ),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: product['id']!,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        product['image']!,
                        height: screenWidth *0.40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      product['title']!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
