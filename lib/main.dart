// import 'package:flutter/material.dart';
// import 'package:inventory_project/cart_screen.dart';
// import 'package:inventory_project/home_screen.dart';
// import 'package:inventory_project/productdetails_screen.dart';
// import 'package:inventory_project/profile_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Inventory App',
//       home: MainScreen(),
//     );
//   }
// }

// ignore_for_file: dangling_library_doc_comments, await_only_futures, unused_import

//////////Toggle Switch//////////////
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/cart_screen.dart';
import 'package:inventory_project/home_screen.dart';
import 'package:inventory_project/model/provider/cart_provider.dart';
import 'package:inventory_project/productdetails_screen.dart';
import 'package:inventory_project/profile_screen.dart';
import 'package:inventory_project/screens/animated_inventory_screen.dart';
import 'package:inventory_project/screens/hero_animation_screen.dart';
import 'package:inventory_project/screens/login_screen.dart';
import 'package:inventory_project/screens/product_listscreen.dart';
import 'package:inventory_project/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCNkyBmfEx6zqcj6rS0gb5RCv_BNLizW_Q",
      appId: "1:507804357182:web:54f6414d1ae04a6cc6376f",
      messagingSenderId: "507804357182",
      projectId: "inventoryapp-4bc90",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, Theme, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'Inventory App',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
    // ProductScreen(),
    ProductListScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory App"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.black12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      backgroundColor: Colors.blue,
    );
  }
}
