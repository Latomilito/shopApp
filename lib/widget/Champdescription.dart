import 'package:flutter/material.dart';

class ChampDescriptionProduit extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  ChampDescriptionProduit({this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 2, // Vous pouvez ajuster le nombre de lignes
      decoration: const InputDecoration(
        labelText: 'Description du Produit',
        hintText: 'Entrez la description du produit',
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
