import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/pages/producDetails2.dart';
import 'package:shopapp/widget/produiWidget.dart';

import '../controllers.dart/appController.dart';
import '../models/productModels.dart';
import '../widget/promotionSlider.dart';

// ignore: must_be_immutable
class CategorieVendeur extends StatefulWidget {
  String? categorieSelected;
  CategorieVendeur({super.key, this.categorieSelected});

  @override
  State<CategorieVendeur> createState() => _CategorieVendeurState();
}

class _CategorieVendeurState extends State<CategorieVendeur> {
  List<Produit> produitsFiltres = [];

  Set<Produit> productNamesSet =
      repositoryController.allproduits.map((element) => element).toSet();

  String filterQuery = '';
  void filtrerProduits(
    double minPrice,
    double maxPrice,
  ) {
    setState(() {
      // Réinitialisez la liste des produits filtrés à tous les produits
      produitsFiltres = List.from(productNamesSet.toList());

      // Appliquez les filtres
      produitsFiltres = produitsFiltres
          .where((produit) =>
              produit.prix! >= minPrice && produit.prix! <= maxPrice)
          .toList();
    });
  }

  Future<void> showFilterBottomSheet(
      BuildContext context,
      Function(
        double,
        double,
      ) onFilterApplied) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FilterBottomSheet(onFilterApplied: onFilterApplied);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    produitsFiltres.addAll(productNamesSet.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showFilterBottomSheet(context, filtrerProduits);
                },
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.red,
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.categorieSelected!,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: MediaQuery.of(context).size.height /
                        3.5, // Ajustez cette valeur en fonction de la taille souhaitée
                    mainAxisSpacing: 3.5,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent:
                        MediaQuery.of(context).size.width / 2.1),
                itemCount: produitsFiltres
                    .where((element) =>
                        element.categorie! == widget.categorieSelected)
                    .where((productName) => (productName.nom!
                            .toLowerCase()
                            .contains(filterQuery.toLowerCase()) ||
                        productName.categorie!
                            .toLowerCase()
                            .contains(filterQuery.toLowerCase())))
                    .length,
                itemBuilder: (context, index) {
                  Produit product = produitsFiltres
                      .where((element) =>
                          element.categorie! == widget.categorieSelected)
                      .where((productName) => (productName.nom!
                              .toLowerCase()
                              .contains(filterQuery.toLowerCase()) ||
                          productName.categorie!
                              .toLowerCase()
                              .contains(filterQuery.toLowerCase())))
                      .elementAt(index);
                  return ProduitWidget(produit: product);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final Function(double, double) onFilterApplied;

  FilterBottomSheet({required this.onFilterApplied});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double _minPrice = 0.0;
  double _maxPrice = 100.0;
  bool _includeOutOfStock = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filtrer les produits'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_minPrice - $_maxPrice',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            RangeSlider(
              divisions: 20,
              values: RangeValues(_minPrice, _maxPrice),
              min: 0.0,
              max: 20000.0,
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _includeOutOfStock,
                  onChanged: (bool? value) {
                    setState(() {
                      _includeOutOfStock = value ?? false;
                    });
                  },
                ),
                Text('Inclure les produits en rupture de stock'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Retourne les valeurs sélectionnées à la page parente
                widget.onFilterApplied(
                  _minPrice,
                  _maxPrice,
                );
                Navigator.of(context).pop();
              },
              child: Text('Appliquer les filtres'),
            ),
          ],
        ),
      ),
    );
  }
}
