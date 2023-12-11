import 'package:flutter/material.dart';

import '../widget/appercuProduit.dart';

class Appercu extends StatefulWidget {
  const Appercu({super.key});

  @override
  State<Appercu> createState() => _AppercuState();
}

class _AppercuState extends State<Appercu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ApercuProduit(
              nom: 'Nom du produit',
              description: 'Description du produit...',
              prix: 29.99,
              quantiteEnStock: 50,
              image: 'https://exemple.com/image-produit.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
