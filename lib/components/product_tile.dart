import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/shop.dart';
import 'package:shopapp/pages/detailed_product.dart';

class ProductTile extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String description;
  final int productID;
  const ProductTile(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.productID,
      required this.description});

  @override
  Widget build(BuildContext context) {
    void addToCart(BuildContext context) {
      context.read<Shop>().addProductToCart(Product(
          title: title, price: price, image: image, productID: productID));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
              child: Text(
            'Item added to cart',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          )),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailedProduct(
              title: title,
              description: description,
              price: price,
              image: image,
              productID: productID,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Image.network(image)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$' + price),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () => addToCart(context),
                        icon: const Icon(Icons.add)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
