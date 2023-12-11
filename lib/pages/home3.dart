import 'package:flutter/material.dart';

class Boutique {
  final String nom;
  final String logo;

  Boutique(this.nom, this.logo);
}

class produittt {
  final String nom;
  final double prix;
  final Boutique boutique;

  produittt(this.nom, this.prix, this.boutique);
}

class Aceuilllll extends StatelessWidget {
  final List<Boutique> boutiques = [
    Boutique("Ma Boutique", "assets/assets/5.jpg"),
    Boutique("Boutique ABC", "assets/assets/5.jpg"),
    // Ajoutez d'autres boutiques ici
  ];

  final List<produittt> produits = [
    produittt("produittt 1", 25.0, Boutique("Ma Boutique", "assets/5.jpg")),
    produittt("produittt 2", 30.0, Boutique("Boutique ABC", "assets/5.jpg")),
    produittt("produittt 3", 20.0, Boutique("Ma Boutique", "assets/5.jpg")),
    // Ajoutez d'autres produits ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ma Plateforme')),
      body: ListView(
        children: [
          // Carrousel d'images (Section 1)
          // ...

          // Nouvelles Publications (Section 2)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nouvelles Publications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Column(
                children: produits.map((produittt) {
                  return ListTile(
                    leading: Image.asset(produittt.boutique.logo),
                    title: Text(produittt.nom),
                    subtitle: Text(produittt.boutique.nom),
                    trailing: Text('\$${produittt.prix}'),
                  );
                }).toList(),
              ),
            ],
          ),

          // Grille des Différentes Boutiques (Section 3)
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: boutiques.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/5.jpg'),
                    Text(boutiques[index].nom),
                  ],
                ),
              );
            },
          ),

          // Liste de Produits Mélangés (Section 4)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: produits.map((produittt) {
              return ListTile(
                title: Text(produittt.nom),
                subtitle:
                    Text('${produittt.boutique.nom} - \$${produittt.prix}'),
                leading: Image.asset(produittt.boutique.logo),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
