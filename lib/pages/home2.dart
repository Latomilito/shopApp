import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/pages/home3.dart';
import 'package:shopapp/widget/promotionSlider.dart';

import '../controllers.dart/appController.dart';
import '../models/StandarPublication.dart';
import '../models/productModels.dart';
import '../widget/SliderProduct.dart';
import '../widget/buildCategoryGrid.dart';
import 'CategoriPag.dart';
import 'ProducDetails.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Sana\'s market',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 110,
              width: double.infinity,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(360)),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        // height: 100,
                        width: 110,
                        imageUrl:
                            repositoryController.allproduits[8].images!.first),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('400',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Abonnés',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Icon(
                              Icons.send_rounded,
                              color: Colors.orange,
                            ),
                            Icon(
                              Icons.phone,
                              color: Colors.orange,
                            )
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      const Spacer(),
                      const Text(
                        'Notre mission est de vous offrir une sélection soigneusement curated de [produits ou catégories de produits] qui reflètent le style, l\'élégance et la fonctionnalité',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ))
                ],
              ),
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
              // color: Colors.grey.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPage = 0;
                        });
                        pageController.jumpToPage(_currentPage);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        primary:
                            _currentPage == 0 ? Colors.orange : Colors.grey,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pulications',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPage = 1;
                        });
                        pageController.jumpToPage(_currentPage);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        primary:
                            _currentPage == 1 ? Colors.orange : Colors.grey,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Catégories',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
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
                          stream: repositoryController.allpublication(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                  'Erreur de chargement des données');
                            } else {
                              final List<PublicationStandard> publication =
                                  snapshot
                                      .data!
                                      .where((element) =>
                                          element.productIds!.isNotEmpty)
                                      .toList();

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: publication.length,
                                itemBuilder: (context, index) {
                                  List<String> produitsid =
                                      publication[index].productIds!;
                                  List<Produit> produits = repositoryController
                                      .allproduits
                                      .where((element) =>
                                          produitsid.contains(element.id))
                                      .toList();
                                  // String categorie =
                                  //     produitsParCategorie.keys.elementAt(index);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // buildCategorySection(categorie),
                                      // buildCategoryGrid2(
                                      //     creerListeAvecImagesMultiples(
                                      //         produitsParCategorie[categorie]!),
                                      //     categorie),
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
                          stream: repositoryController.allproduct(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                  'Erreur de chargement des données');
                            } else {
                              final List<Produit> produits = snapshot.data!;

                              Map<String, List<Produit>> produitsParCategorie =
                                  {};
                              for (var produit in produits) {
                                if (!produitsParCategorie
                                    .containsKey(produit.categorie!)) {
                                  produitsParCategorie[produit.categorie!] = [];
                                }
                                produitsParCategorie[produit.categorie!]!
                                    .add(produit);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: produitsParCategorie.length,
                                itemBuilder: (context, index) {
                                  String categorie = produitsParCategorie.keys
                                      .elementAt(index);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // buildCategorySection(categorie),
                                      // buildCategoryGrid2(
                                      //     creerListeAvecImagesMultiples(
                                      //         produitsParCategorie[categorie]!),
                                      //     categorie),
                                      buildCategoryGrid(
                                          nombreArticles: 6,
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
    );
  }

  Widget buildCategorySection(String title) {
    return Container(
      // alignment: Alignment.center,
      // height: 50,
      margin: const EdgeInsets.only(top: 5),
      // padding: const EdgeInsets.all(7),
      width: double.infinity,
      color: Colors.grey.withOpacity(0.1),
      child: Text(
        title,
        style: const TextStyle(color: Colors.orange, fontSize: 16),
      ),
    );
  }

  Widget buildCategoryGrid2(List<Produit> produits, String title) {
    onProductNameSelected(Produit productName) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return DetailsPage(
          produit: productName,
        );
      }));
      print('Nom de produit sélectionné: $productName');
    }

    return Card(
      // color: Colors.grey.withOpacity(0.3),
      // elevation: 5,
      // shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          buildCategorySection(title),
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: produits.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DetailsPage(
                        produit: produits[index],
                      );
                    }));
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: double.maxFinite,
                          width: double.infinity,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.withOpacity(0.2),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    )),
                              ],
                            ),
                          ),
                          imageUrl: produits[index].images!.first,
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryGrid3(List<Produit> produits, String title) {
    onProductNameSelected(Produit productName) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return DetailsPage(
          produit: productName,
        );
      }));
      print('Nom de produit sélectionné: $productName');
    }

    return Card(
      // color: Colors.grey.withOpacity(0.3),
      // elevation: 5,
      // shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          buildCategorySection(title),
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: produits.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DetailsPage(
                        produit: produits[index],
                      );
                    }));
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: double.maxFinite,
                          width: double.infinity,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.withOpacity(0.2),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    )),
                              ],
                            ),
                          ),
                          imageUrl: produits[index].images!.first,
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
