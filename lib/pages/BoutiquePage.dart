import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controllers.dart/appController.dart';
import '../models/StandarPublication.dart';
import '../models/productModels.dart';
import '../widget/buildCategoryGrid.dart';

class BoutiquePage extends StatefulWidget {
  @override
  State<BoutiquePage> createState() => _homeState();
}

class _homeState extends State<BoutiquePage> {
  int _currentPage = 0;
  // List<String> categories = [];
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    // repositoryController.allproduits.forEach((element) {
    //   categories.add(element.categorie!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Set<Produit> categoriesSet =
        repositoryController.allproduits.map((element) => element).toSet();
    List<Produit> creerListeAvecImagesMultiples(List<Produit> produits) {
      List<Produit> nouvelleListe = [];

      for (Produit produit in produits) {
        for (String image in produit.images!) {
          // Créer une copie du produit avec une seule image
          Produit nouveauProduit = Produit(
              id: produit.id,
              description: produit.description,
              categorie: produit.categorie,
              estNouveau: produit.estNouveau,
              prix: produit.prix,
              estPopulaire: produit.estPopulaire,
              nom: produit.nom,
              images: [image]);
          nouvelleListe.add(nouveauProduit);
        }
      }

      return nouvelleListe;
    }

    final List<String> images = [
      'assets/pub.jpg',
      'assets/pub1.jpg',
    ];

    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0, expandedHeight: 200,
              // expandedHeight: 200.0,
              floating: true,
              pinned: true,
              stretch: true,

              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                title: const Text(
                  'Sana\'s market',
                  style: TextStyle(color: Colors.black),
                ),
                background: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(360)),
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 100,
                            width: 110,
                            imageUrl: repositoryController
                                .allproduits[8].images!.first),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Card(
                  elevation: 2,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(top: 10, right: 5, left: 5),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S\'abonné',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPage = 0;
                          });
                          pageController.jumpToPage(_currentPage);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: _currentPage == 0
                                ? Colors.red
                                : Colors.transparent,
                          ))),
                          child: const Text(
                            'Pulications',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPage = 1;
                          });
                          pageController.jumpToPage(_currentPage);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: _currentPage == 1
                                ? Colors.red
                                : Colors.transparent,
                          ))),
                          child: const Text(
                            'Catalogue',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            StreamBuilder<List<PublicationStandard>>(
                              // stream: repositoryController.allpublication(),
                              stream: null,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text(
                                      'Erreur de chargement des données');
                                } else {
                                  // final List<PublicationStandard> publication =
                                  //     snapshot
                                  //         .data!
                                  //         .where((element) =>
                                  //             element.productIds!.isNotEmpty)
                                  //         .toList();
                                  final List<PublicationStandard> publication =
                                      repositoryController.allpublications
                                          .where((element) =>
                                              element.productIds!.isNotEmpty)
                                          .toList();

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: publication.length,
                                    itemBuilder: (context, index) {
                                      List<String> produitsid =
                                          publication[index].productIds!;
                                      List<Produit> produits =
                                          repositoryController.allproduits
                                              .where((element) => produitsid
                                                  .contains(element.id))
                                              .toList();
                                      // String categorie =
                                      //     produitsParCategorie.keys.elementAt(index);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildCategoryGrid(
                                              publication: publication[index],
                                              nombreArticles: publication[index]
                                                  .productIds!
                                                  .length,
                                              produits: produits,
                                              title: ''),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            StreamBuilder<List<Produit>>(
                              // stream: repositoryController.allproduct(),
                              stream: null,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text(
                                      'Erreur de chargement des données');
                                } else {
                                  // final List<Produit> produits = snapshot.data!;
                                  final List<Produit> produits =
                                      repositoryController.allproduits;

                                  Map<String, List<Produit>>
                                      produitsParCategorie = {};
                                  for (var produit in produits) {
                                    if (!produitsParCategorie
                                        .containsKey(produit.categorie!)) {
                                      produitsParCategorie[produit.categorie!] =
                                          [];
                                    }
                                    produitsParCategorie[produit.categorie!]!
                                        .add(produit);
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: produitsParCategorie.length,
                                    itemBuilder: (context, index) {
                                      String categorie = produitsParCategorie
                                          .keys
                                          .elementAt(index);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildCategoryGrid(
                                              nombreArticles: 8,
                                              produits:
                                                  creerListeAvecImagesMultiples(
                                                      produitsParCategorie[
                                                          categorie]!),
                                              title: categorie),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
