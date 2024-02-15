import 'package:flutter/material.dart';

class PageajouterProdui extends StatefulWidget {
  const PageajouterProdui({super.key});

  @override
  State<PageajouterProdui> createState() => _PageajouterProduiState();
}

class _PageajouterProduiState extends State<PageajouterProdui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ajouter un produit',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
      ),
      body: const Column(),
    );
  }
}
