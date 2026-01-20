// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:basics/upi_payment_screen.dart';

class Clothes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('CLOTHES'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildProductCard(context, 'Chucky Dress', 'assets/clothes.jfif', 850),
          buildProductCard(context, 'Raincoat', 'assets/clothes.jfif', 720),
          buildProductCard(context, 'Banana Dress', 'assets/clothes.jfif', 900),
          buildProductCard(context, 'Dog tuxedo', 'assets/clothes.jfif', 1200),
          buildProductCard(context, 'Woven Dress', 'assets/clothes.jfif', 684),
          buildProductCard(context, 'Winter Jacket', 'assets/clothes.jfif', 1320),
          buildProductCard(context, 'Cosplay spider', 'assets/clothes.jfif', 950),
        ],
      ),
    );
  }

  Widget buildProductCard(BuildContext context, String productName, String assetPath, double productPrice) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productName: productName,
              productImage: assetPath,
              productPrice: productPrice,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Image.asset(
            assetPath,
            width: 73,
            height: 73,
            fit: BoxFit.cover,
          ),
          title: Text(productName),
          subtitle: Text('Rs$productPrice'),
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;

  const ProductDetailScreen({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  productImage,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rs$productPrice',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Premium quality pet clothing made from soft and durable materials. Perfect for keeping your pet comfortable and stylish.',
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpiPaymentScreen(
                          order: 0,
                          packageName: 'Cloth',
                          packagePrice: productPrice.toString(),
                          packageDetails: '',
                        ),
                      ),
                    );
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
