import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';

class SelectionProduitsPromotionPage extends StatefulWidget {
  const SelectionProduitsPromotionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectionProduitsPromotionPageState createState() =>
      _SelectionProduitsPromotionPageState();
}

class _SelectionProduitsPromotionPageState
    extends State<SelectionProduitsPromotionPage> {
  List<String> selectedProductIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner des produits'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Appliquez la promotion aux produits sélectionnés
              applyPromotionToSelectedProducts();
            },
            child: const Text('Appliquer la promotion'),
          ),
        ],
      ),
      body: StreamBuilder<List<Produit>>(
        stream: repositoryController.allproduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Produit> produits = snapshot.data ?? [];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Nombre de colonnes dans la grille
            ),
            itemCount: produits.length,
            itemBuilder: (context, index) {
              Produit produit = produits[index];
              bool isSelected = selectedProductIds.contains(produit.id);

              return GestureDetector(
                onTap: () {
                  // Gérer la sélection du produit
                  setState(() {
                    if (isSelected) {
                      selectedProductIds.remove(produit.id ?? '');
                    } else {
                      selectedProductIds.add(produit.id ?? '');
                    }
                  });
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          produit.images?.first ?? '',
                          // height: MediaQuery.of(context).size.height /
                          // 7.5, // Ajustez la hauteur selon vos besoins
                          width: double
                              .infinity, // Ajustez la largeur selon vos besoins
                          fit: BoxFit.fill,
                        ),
                      ),
                      ListTile(
                        title: Text(produit.nom ?? ''),
                        subtitle: Text(produit.prix.toString() ?? ''),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            // Gérer la sélection du produit
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedProductIds.add(produit.id ?? '');
                                } else {
                                  selectedProductIds.remove(produit.id ?? '');
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void applyPromotionToSelectedProducts() {
    // Appliquez la promotion aux produits sélectionnés ici
    // Vous pouvez utiliser la liste de selectedProductIds
    // pour identifier les produits à inclure dans la promotion
    // et effectuer les modifications nécessaires dans votre application.
  }
}
