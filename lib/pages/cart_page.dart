import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/shop.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartProducts = [];

  Future<void> apiCall() async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.com/carts/user/4"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming the first cart object for the user
        if (data.isNotEmpty) {
          final products = data[0]['products'];
          // Fetch product details for each productId in the cart
          for (var product in products) {
            final productDetails =
                await fetchProductDetails(product['productId']);
            setState(() {
              cartProducts.add({
                ...productDetails,
                'quantity': product['quantity'],
              });
            });
          }
        }
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/$productId"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  void removeItemFromCart(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        content: Text(
          "Remove this item from your cart?",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                cartProducts.remove(product);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'Item removed from your cart',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
              );
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Cart Page"),
      ),
      body: cartProducts.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Theme.of(context).colorScheme.primary,
                    leading: Image.network(product['image']),
                    title: Text(product['title']),
                    subtitle: Text('\$' + product['price'].toString()),
                    trailing: IconButton(
                      onPressed: () => removeItemFromCart(context, product),
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
