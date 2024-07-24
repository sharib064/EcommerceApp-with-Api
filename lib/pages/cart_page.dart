import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/shop.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItemFromCart(BuildContext context, Product product) {
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
              context.read<Shop>().removeItemFromCart(product);
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
              Navigator.pop(context);
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
    List<Product> cartProducts = Provider.of<Shop>(context).getUserCart();
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
                    leading: Image.network(product.image),
                    title: Text(product.title),
                    subtitle: Text('\$' + product.price),
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
