import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Running Shoes",
      "image": "lib/assets/images/shoes.jpg",
      "price": "\$199",
      "desc": "Premium leather strap and water resistant."
    },
    {
      "name": "Luxury Watch",
      "image": "lib/assets/images/watch.jpg",
      "price": "\$99",
      "desc": "Comfortable and lightweight sports shoes."
    },
    {
      "name": "Designer Bag",
      "image": "lib/assets/images/bag.jpg",
      "price": "\$149",
      "desc": "Stylish bag for everyday use."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: Column(
            children: [
              Image.network(product['image']!, height: 100, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name']!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(product['desc']!),
                    SizedBox(height: 4),
                    Text(product['price']!,
                        style: TextStyle(color: Colors.green, fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
