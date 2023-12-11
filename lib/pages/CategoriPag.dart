import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/ProducDetails.dart';
import 'package:shopapp/pages/historiquePage.dart';
import 'package:shopapp/pages/producDetails2.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int? selectedindex;
  String? categorieSelected;
  String filterQuery = '';
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();

  Set<Produit> productNamesSet =
      repositoryController.allproduits.map((element) => element).toSet();

  void onCategorySelected(String category) {
    List<Produit> produis = repositoryController.allproduits
        .where((element) => element.categorie == category)
        .toList();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(categorieCherche: category);
    }));
    print('Catégorie sélectionnée: $category');
  }

  void onProductNameSelected(Produit productName) {
    // Produit produi = repositoryController.allproduits.firstWhere((element) => element.images.first=)

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage2(
        produit: productName,
        isProduiCherche: true,
      );
    }));
    print('Nom de produit sélectionné: $productName');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        setState(() {
                          filterQuery = query;
                          categorieSelected = null;
                          selectedindex = null;
                        });
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Rechercher une catégorie ou un nom de produit',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Recherche',
                    style: TextStyle(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.black,
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                children: [
                  Text(
                    'Catégories',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    // color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // spacing: 8.0,
                        // runSpacing: 8.0,
                        children: categoriesSet
                            .where((category) => category
                                .toLowerCase()
                                .contains(filterQuery.toLowerCase()))
                            .map((category) {
                          int index = categoriesSet
                              .where((category) => category
                                  .toLowerCase()
                                  .contains(filterQuery.toLowerCase()))
                              .toList()
                              .indexOf(category);
                          Produit produit = repositoryController.allproduits
                              .firstWhere(
                                  (element) => element.categorie == category);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                                categorieSelected = category;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: selectedindex == index
                                    ? Border.all(width: 2, color: Colors.orange)
                                    : null,
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      height: 70,
                                      width: 85,
                                      imageUrl: produit.images!.first,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Text(
                                      produit.categorie!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      children: [
                        Text(
                          'Produits',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: categorieSelected == null
                        ? SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: productNamesSet
                                  .where((productName) => (productName.nom!
                                          .toLowerCase()
                                          .contains(
                                              filterQuery.toLowerCase()) ||
                                      productName.categorie!
                                          .toLowerCase()
                                          .contains(filterQuery.toLowerCase())))
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailsPage2(
                                            produit: e,
                                            isProduiCherche: false,
                                          );
                                        }));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
                                            margin: const EdgeInsets.all(2),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CachedNetworkImage(
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl: e.images!.first,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              margin: const EdgeInsets.all(2),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              // height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.nom == ''
                                                        ? e.categorie!
                                                        : e.nom!,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  ),
                                                  const Text(
                                                    '5000 FCFA',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                        backgroundColor:
                                                            Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    360)),
                                                        child: CachedNetworkImage(
                                                            height: 20,
                                                            width: 20,
                                                            imageUrl:
                                                                repositoryController
                                                                    .allproduits
                                                                    .first
                                                                    .images!
                                                                    .first),
                                                      ),
                                                      const Text(
                                                        'Sana\'s market',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: productNamesSet
                                  .where((productName) =>
                                      (productName.categorie! ==
                                          categorieSelected))
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailsPage2(
                                            produit: e,
                                            isProduiCherche: false,
                                          );
                                        }));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
                                            margin: const EdgeInsets.all(2),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CachedNetworkImage(
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl: e.images!.first,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              margin: const EdgeInsets.all(2),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              // height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.nom == ''
                                                        ? e.categorie!
                                                        : e.nom!,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  ),
                                                  const Text(
                                                    '5000 FCFA',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                        backgroundColor:
                                                            Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    360)),
                                                        child: CachedNetworkImage(
                                                            height: 20,
                                                            width: 20,
                                                            imageUrl:
                                                                repositoryController
                                                                    .allproduits
                                                                    .first
                                                                    .images!
                                                                    .first),
                                                      ),
                                                      const Text(
                                                        'Sana\'s market',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
