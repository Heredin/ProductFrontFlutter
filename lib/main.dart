import 'package:flutter/material.dart';
import 'package:productos_flutter/src/screens/home_screen.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Availables',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              elevation: 0.0, color: Color.fromARGB(255, 162, 134, 209))),
      home: HomeScreen(
        key: key,
      ),
    );
  }
}
