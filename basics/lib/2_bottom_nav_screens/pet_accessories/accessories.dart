import 'package:flutter/material.dart';
import 'package:basics/upi_payment_screen.dart';

class Accessories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('ACCESSORIES')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        buildCard(context, 'Mouth Cover muzzles', 'assets/accessories.jfif', 2490),
        buildCard(context, 'Hair Brush', 'assets/accessories.jfif', 450),
        buildCard(context, 'Portable Bed', 'assets/accessories.jfif', 1800),
        buildCard(context, 'Dog Harness', 'assets/accessories.jfif', 990),
        buildCard(context, 'Dog leash', 'assets/accessories.jfif', 340),
        buildCard(context, 'Retractable Dog Leash', 'assets/accessories.jfif', 720),
        buildCard(context, 'Food Bowl 700ml', 'assets/accessories.jfif', 270),
      ]),
    );
  }

  Widget buildCard(BuildContext context, String name, String asset, double price) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(name, asset, price))),
    child: Card(child: ListTile(leading: Image.asset(asset, width: 60, height: 60, fit: BoxFit.cover), title: Text(name), subtitle: Text('Rs'))),
  );
}

class DetailScreen extends StatelessWidget {
  final String name, asset;
  final double price;
  DetailScreen(this.name, this.asset, this.price);
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(name)), body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Center(child: Image.asset(asset, width: 200, height: 200, fit: BoxFit.cover)), const SizedBox(height: 20), Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Text('Rs', style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)), const SizedBox(height: 30), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UpiPaymentScreen(order: 1, packageName: name, packagePrice: price.toString(), packageDetails: 'Accessory'))), child: const Text('Buy Now')))]))));
}
