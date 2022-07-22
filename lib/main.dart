import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/ui/product/product_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme(
          primary: Colors.black,
          secondary: Colors.black87,
          surface: Colors.purpleAccent,
          background: Colors.white,
          error: Colors.redAccent,
          onPrimary: Colors.red,
          onSecondary: Colors.deepOrange,
          onSurface: Colors.black54,
          onBackground: Colors.black87,
          onError: Colors.redAccent,
          brightness: Brightness.light,
        ),
      ),
      home: const ProductSearch(),
    );
  }
}
