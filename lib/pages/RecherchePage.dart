import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/producDetails2.dart';
import 'package:shopapp/widget/produiWidget.dart';

import 'allCategories.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  List<String?> favoris =
      authController.usermodel.value.cartList!.map((e) => e.productId).toList();
  int? selectedindex;
  String? categorieSelected;
  String filterQuery = '';
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();

  Set<Produit> productNamesSet =
      repositoryController.allproduits.map((element) => element).toSet();

  void onProductNameSelected(Produit productName) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage2(
        produit: productName,
        isFromCategorie: true,
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
            Container(
              // color: Colors.grey,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextField(
                          onChanged: (query) {
                            setState(() {
                              filterQuery = query;
                              categorieSelected = null;
                              selectedindex = null;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            hintText:
                                'Rechercher une catégorie ou un nom de produit',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          shape: const CircleBorder()),
                      onPressed: () {},
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
              child: Row(
                children: [
                  const Text(
                    'Catégories',
                    style: TextStyle(fontSize: 17),
                  ),
                  const Spacer(),
                  // if (widget.isFromCategorie!)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const AllcategoriesPage();
                      }));
                    },
                    child: const Text('voir plus'),
                  )
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
                                    ? Border.all(width: 2, color: Colors.red)
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
                                          color: Colors.white, fontSize: 16),
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
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: MediaQuery.of(context).size.height /
                              3.5, // Ajustez cette valeur en fonction de la taille souhaitée
                          mainAxisSpacing: 3.5,
                          crossAxisSpacing: 10,
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2.1),
                      itemCount: categorieSelected == null
                          ? productNamesSet
                              .where((productName) => (productName.nom!
                                      .toLowerCase()
                                      .contains(filterQuery.toLowerCase()) ||
                                  productName.categorie!
                                      .toLowerCase()
                                      .contains(filterQuery.toLowerCase())))
                              .length
                          : productNamesSet
                              .where((productName) =>
                                  (productName.categorie! == categorieSelected))
                              .length,
                      itemBuilder: (context, index) {
                        Produit product = categorieSelected == null
                            ? productNamesSet
                                .where((productName) => (productName.nom!
                                        .toLowerCase()
                                        .contains(filterQuery.toLowerCase()) ||
                                    productName.categorie!
                                        .toLowerCase()
                                        .contains(filterQuery.toLowerCase())))
                                .elementAt(index)
                            : productNamesSet
                                .where((productName) =>
                                    (productName.categorie! ==
                                        categorieSelected))
                                .elementAt(index);
                        return ProduitWidget(produit: product);
                      },
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
