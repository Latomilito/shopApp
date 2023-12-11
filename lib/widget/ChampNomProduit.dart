import 'package:flutter/material.dart';

class ChampNomProduit extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  ChampNomProduit({this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Nom du Produit',
          hintText: 'Entrez le nom du produit',
          border: OutlineInputBorder(),
        ),
        validator: validator);
  }
}
