// import 'package:flutter/material.dart';

// ignore_for_file: dangling_library_doc_comments

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "Welcome Home!",
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
///////Toggle Switch//////
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Toggle switch!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
