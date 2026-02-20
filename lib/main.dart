import 'package:flutter/material.dart';

void main() {
  runApp(const ElectronicShop());
}

class ElectronicShop extends StatelessWidget {
  const ElectronicShop({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electronic Shop',
      home: Scaffold(),
    );
  }
}
