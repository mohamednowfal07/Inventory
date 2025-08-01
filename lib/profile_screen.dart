import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // User Avatar
          CircleAvatar(
            radius: 50,
            backgroundImage:
                AssetImage('assets/images/spider logo.jpg'), // or NetworkImage
          ),
          SizedBox(height: 50),
          // Name and Email
          Text(
            'Mohamed Nowfal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'nowfal161203@gmail.com',
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 30),
          Divider(),

          // Profile Options
          Expanded(
            child: ListView(
              children: [
                buildProfileTile(Icons.shopping_bag, 'My Orders', () {}),
                buildProfileTile(Icons.favorite_border, 'Wishlist', () {}),
                buildProfileTile(Icons.location_on, 'Address Book', () {}),
                buildProfileTile(Icons.settings, 'Settings', () {}),
                buildProfileTile(Icons.logout, 'Logout', () {
                  // Logout logic here
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
