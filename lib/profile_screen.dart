import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text("Name: Dominic Toretto"),
          Text("Email: dominic@example.com"),
          Text("Address: Los Angeles, California"),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          Text("Orders: 12"),
          Text("Wishlist: 5"),
        ],
      ),
    );
  }
}
