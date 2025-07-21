// ///////Toggle Switch//////
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'theme_provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(""),
//         actions: [
//           Switch(
//             value: themeProvider.isDarkMode,
//             onChanged: (value) {
//               themeProvider.toggleTheme(value);
//             },
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text(
//           "Toggle switch!",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:inventory_project/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  void loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username ?? ''),
              accountEmail: Text('$username@example.com'),
              currentAccountPicture: CircleAvatar(
                child: Text(username != null ? username![0] : 'U'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Welcome, $username!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
