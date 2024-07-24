import 'package:flutter/material.dart';
import 'package:shopapp/models/shop.dart';
import 'package:shopapp/pages/cart_page.dart';
import 'package:shopapp/pages/intro_page.dart';
import 'package:shopapp/pages/shop_page.dart';
import 'package:shopapp/themes/light_mode.dart';
import 'package:provider/provider.dart';

void main() {
  runApp((ChangeNotifierProvider(
    create: (context) => Shop(),
    child: const MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: lightMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/shop_page': (context) => const ShopPage(),
        '/cart_page': (context) => const CartPage(),
      },
    );
  }
}
