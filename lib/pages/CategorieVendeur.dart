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
  final List<String> images = [
    'assets/pub.jpg',
    'assets/pub1.jpg',
  ];
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
                  color: Colors.black,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SliderPromotion(images: images),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.grey.withOpacity(0.2),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Produits populaire',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: produitsFiltres
                            .where((element) =>
                                element.categorie! == widget.categorieSelected)
                            .where((productName) => (productName.nom!
                                    .toLowerCase()
                                    .contains(filterQuery.toLowerCase()) ||
                                productName.categorie!
                                    .toLowerCase()
                                    .contains(filterQuery.toLowerCase())))
                            .map((e) {
                          return ProduitWidget(
                            produits: [e],
                            isPageDetails3: false,
                            isAllList: false,
                            produit: e,
                            isCreateCategorie: false,
                            isFromcategorie: true,
                          );
                        }).toList(),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.grey.withOpacity(0.2),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nouveautés',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: produitsFiltres
                            .where((element) =>
                                element.categorie! == widget.categorieSelected)
                            .where((productName) => (productName.nom!
                                    .toLowerCase()
                                    .contains(filterQuery.toLowerCase()) ||
                                productName.categorie!
                                    .toLowerCase()
                                    .contains(filterQuery.toLowerCase())))
                            .map((e) {
                          return ProduitWidget(
                            produits: [e],
                            isPageDetails3: false,
                            isFromcategorie: true,
                            isAllList: false,
                            produit: e,
                            isCreateCategorie: false,
                          );
                        }).toList(),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.grey.withOpacity(0.2),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Tous les produis',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // Wrap(
                //   children: produitsFiltres
                //       .where((element) =>
                //           element.categorie! == widget.categorieSelected)
                //       .where((productName) => (productName.nom!
                //               .toLowerCase()
                //               .contains(filterQuery.toLowerCase()) ||
                //           productName.categorie!
                //               .toLowerCase()
                //               .contains(filterQuery.toLowerCase())))
                //       .map((e) {
                //     return ProduitWidget(
                //       isAllList: true,
                //       produit: e,
                //       isCreateCategorie: false,
                //     );
                //   }).toList(),
                // ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: MediaQuery.of(context).size.height /
                          3.8, // Ajustez cette valeur en fonction de la taille souhaitée
                      mainAxisSpacing: 3.5,
                      // crossAxisSpacing: 5,
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width / 2),
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
                    return ProduitWidget(
                      produits: [product],
                      produit: product,
                      isPageDetails3: false,
                      isCreateCategorie: false,
                      isAllList: true,
                      isFromcategorie: true,
                    );
                  },
                )
              ],
            ),
          ),
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
                  style:
                      const TextStyle(color: Colors.transparent, fontSize: 20),
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
