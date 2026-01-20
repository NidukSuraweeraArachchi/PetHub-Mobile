import 'package:flutter/material.dart';
import 'package:basics/upi_payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine extends StatelessWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('MEDICINE')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        buildCard(context, 'Alfalfa tonic', 'assets/medicine.jfif', 250),
        buildCard(context, 'Diarrhoea tablets', 'assets/medicine.jfif', 90),
        buildCard(context, 'Drop for excessive thirst', 'assets/medicine.jfif', 100),
        buildCard(context, 'Ear drop', 'assets/medicine.jfif', 130),
        buildCard(context, 'Wound lotion', 'assets/medicine.jfif', 684),
        buildCard(context, 'Joint Tablets', 'assets/medicine.jfif', 180),
        buildCard(context, 'Liv 52 metabolism', 'assets/medicine.jfif', 350),
        buildCard(context, 'Multivitamin for pets', 'assets/medicine.jfif', 350),
      ]),
    );
  }

  Widget buildCard(BuildContext context, String name, String asset, double price) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(name, asset, price))),
    child: Card(child: ListTile(leading: Image.asset(asset, width: 60, height: 60, fit: BoxFit.cover), title: Text(name), subtitle: Text('Rs'))),
  );
}

class DetailScreen extends StatefulWidget {
  final String name, asset;
  final double price;
  const DetailScreen(this.name, this.asset, this.price, {Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isAdding = false;

  Future<void> addItemToProfile() async {
    try {
      setState(() => isAdding = true);
      
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login first'), backgroundColor: Colors.red),
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('purchases')
          .add({
        'itemName': widget.name,
        'category': 'Medicine',
        'price': widget.price.toString(),
        'quantity': quantity,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Item added to your profile!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isAdding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  widget.asset,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rs ${widget.price}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: quantity > 1
                              ? () => setState(() => quantity--)
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => quantity++),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: isAdding ? null : addItemToProfile,
                  child: isAdding
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Add to My Items',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpiPaymentScreen(
                        order: 1,
                        packageName: widget.name,
                        packagePrice: widget.price.toString(),
                        packageDetails: 'Medicine',
                      ),
                    ),
                  ),
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
