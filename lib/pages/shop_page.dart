import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopapp/components/product_tile.dart';
import 'package:http/http.dart' as http;

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<dynamic> products = [];

  Future apiCall() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Shop Page"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cart_page'),
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        Icons.trolley,
                        color: Theme.of(context).colorScheme.primary,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      onTap: () {
                        //apiCall();
                        Navigator.pushNamed(context, '/shop_page');
                      },
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Shop",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, '/cart_page'),
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Cart",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, '/intro_page'),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "Exit",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                "Pick from selected list of premium products",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            SizedBox(
              height: 450,
              child: products.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(25),
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) => ProductTile(
                          description: products[index]['description'],
                          productID: products[index]['id'],
                          title: products[index]['title'],
                          price: products[index]['price'].toString(),
                          image: products[index]['image'],
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
