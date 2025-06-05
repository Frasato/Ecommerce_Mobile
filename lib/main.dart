import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/screens/catalog_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:ecommerce_app/screens/register_page.dart';
import 'package:ecommerce_app/screens/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const SplashPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/catalog': (context) => CatalogPage(searchWord: ''),
        '/cart': (context) => CartPage(),
      },
    );
  }
}