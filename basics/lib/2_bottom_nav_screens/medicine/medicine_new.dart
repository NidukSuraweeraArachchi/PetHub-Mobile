import 'package:flutter/material.dart';
import 'package:basics/upi_payment_screen.dart';

class Medicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 45,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildProductCard(context, 'Alfalfa tonic', 'assets/medicine.jfif', 250),
          buildProductCard(context, 'Diarrhoea tablets', 'assets/medicine.jfif', 90),
          buildProductCard(context, 'Drop for excessive thirst', 'assets/medicine.jfif', 100),
          buildProductCard(context, 'Ear drop', 'assets/medicine.jfif', 130),
          buildProductCard(context, 'Wound lotion', 'assets/medicine.jfif', 684),
          buildProductCard(context, 'Joint Tablets', 'assets/medicine.jfif', 180),
          buildProductCard(context, 'Liv 52 metabolism simulation', 'assets/medicine.jfif', 350),
          buildProductCard(context, 'Multivitamin for pets', 'assets/medicine.jfif', 350),
        ],
      ),
    );
  }

  Widget buildProductCard(
    BuildContext context,
    String productName,
    String assetPath,
    double productPrice,
  ) {
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(
            assetPath,
            width: 60,
            height: 60,
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

  ProductDetailScreen({
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

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
                'Premium quality pet medicine. Always consult your veterinarian before use.',
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
                          packageName: 'Medicine',
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
