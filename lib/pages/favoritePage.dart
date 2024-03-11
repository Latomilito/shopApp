import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';

import '../widget/produiWidget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Mes favoris',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Produit>>(
                stream: repositoryController.allproduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Erreur de chargement des données');
                  } else {
                    final List<Produit> produits = snapshot.data!.toList();

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: MediaQuery.of(context).size.height /
                              3.5, // Ajustez cette valeur en fonction de la taille souhaitée
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.height / 2.3),
                      itemCount: produits.length,
                      itemBuilder: (context, index) {
                        Produit product = produits[index];
                        return ProduitWidget(
                          isPageDetails3: false,
                          isAllList: true,
                          produit: product,
                          isCreateCategorie: false,
                          isFromcategorie: false,
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
