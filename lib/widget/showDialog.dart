import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/productModels.dart';
import '../pages/publicationPage.dart';

// import '../Productmodels.dart';

class ProductOptionsDialog extends StatelessWidget {
  final Produit? produit;

  const ProductOptionsDialog({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(produit!.nom!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Supprimer'),
            onTap: () async {
              Navigator.pop(context);
              await FirebaseFirestore.instance
                  .collection('produits')
                  .doc(produit!.id)
                  .delete();
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Modifier'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PublicationPage(
                  produit: produit,
                );
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Ajouter un produit'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PublicationPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
