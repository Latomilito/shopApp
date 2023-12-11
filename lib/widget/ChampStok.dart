import 'package:flutter/material.dart';

class ChampQuantiteEnStock extends StatelessWidget {
  final TextEditingController? controller;

  const ChampQuantiteEnStock({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType:
          TextInputType.number, // Clavier numérique pour les quantités
      decoration: const InputDecoration(
        labelText: 'Quantité en Stock',
        hintText: 'Entrez la quantité en stock du produit',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer la quantité en stock du produit';
        }
        // Vérifiez ici si la valeur est un nombre valide pour la quantité
        // Vous pouvez ajouter des validations spécifiques selon vos besoins
        return null;
      },
    );
  }
}
