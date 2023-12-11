import 'package:flutter/material.dart';

class ApercuProduit extends StatelessWidget {
  final String nom;
  final String description;
  final double prix;
  final int quantiteEnStock;
  final String image;

  const ApercuProduit({
    super.key,
    required this.nom,
    required this.description,
    required this.prix,
    required this.quantiteEnStock,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/chageur.jfif',
            height: 200, // Ajustez la taille de l'image d'aperçu
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          Text(
            nom,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(description),
          const SizedBox(height: 5),
          Text('Prix : $prix \$'),
          Text('Quantité en stock : $quantiteEnStock'),
        ],
      ),
    );
  }
}
