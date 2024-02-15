import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/PublicationPage2.dart';
import 'package:shopapp/pages/RecherchePage.dart';
import 'package:shopapp/pages/commandeInfo.dart';
import 'package:shopapp/pages/favoritePage.dart';
import '../controllers.dart/appController.dart';
import '../widget/buildCategoryGrid.dart';
import '../widget/promotionSlider.dart';
import 'CategorieVendeur.dart';
import 'allCategories.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _Home5State();
}

class _Home5State extends State<AcceuilPage> {
  FocusNode _focusNode = FocusNode();
  void onCategorySelected(String category) {
    List<Produit> produis = repositoryController.allproduits
        .where((element) => element.categorie == category)
        .toList();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CategorieVendeur(
        categorieSelected: category,
      );
    }));
    print('Catégorie sélectionnée: $category');
  }

  List<Produit> allproduits = repositoryController.allproduits;
  final List<PublicationStandard> publication = repositoryController
      .allpublications
      .where((element) => element.productIds!.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    allproduits.shuffle();
    final List<String> images = [
      'assets/pub.jpg',
      'assets/pub1.jpg',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Soft Store',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CommandeInfoPage();
                }));
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Mes favoris'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const FavoritePage();
                    },
                  ));
                },
              ),
              ListTile(
                title: const Text('Faire une annonce'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const PublicationPage2();
                    },
                  ));
                },
              ),
              ListTile(
                title: const Text('Faire une offre'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextField(
                          focusNode: _focusNode,
                          onTap: () {
                            _focusNode.unfocus();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RecherchePage();
                            }));
                          },
                          onChanged: (query) {
                            setState(() {
                              // filterQuery = query;
                              // categorieSelected = null;
                              // selectedindex = null;
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
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         elevation: 0,
                  //         backgroundColor: Colors.white,
                  //         padding: const EdgeInsets.all(10),
                  //         shape: const CircleBorder()),
                  //     onPressed: () {},
                  //     child: const Icon(
                  //       Icons.filter_list,
                  //       color: Colors.red,
                  //     ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0, right: 8, left: 8),
                child: SliderPromotion(
                  images: images,
                ),
              ),
              if (allproduits.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5.5,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        Set<String> categoriesSet = allproduits
                            .map((element) => element.categorie!)
                            .toSet();
                        categoriesSet.toList();
                        String categorie = categoriesSet.toList()[index];
                        Produit produit = repositoryController.allproduits
                            .firstWhere(
                                (element) => element.categorie == categorie);

                        return GestureDetector(
                          onTap: () {
                            index == 9
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                    return const AllcategoriesPage();
                                  }))
                                : onCategorySelected(categorie);
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.height *
                                        0.08,
                                    imageUrl: produit.images!.first,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width:
                                    MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: Text(
                                  index == 9 && (categoriesSet.length - 10) != 0
                                      ? '+ ${categoriesSet.length - 10}'
                                      : categorie.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: index == 9 &&
                                            (categoriesSet.length - 10) != 0
                                        ? 20
                                        : 13,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              StreamBuilder<List<PublicationStandard>>(
                stream: repositoryController.allpublication(),
                // stream: null,
                builder: (BuildContext context, snapshot) {
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
                    final List<PublicationStandard> publication = snapshot.data!
                        .where((element) => element.productIds!.isNotEmpty)
                        .toList();

                    return ListView.builder(
                      dragStartBehavior: DragStartBehavior.down,
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: publication.length,
                      itemBuilder: (context, index) {
                        List<String> produitsid =
                            publication[index].productIds!;
                        List<Produit> produits = repositoryController
                            .allproduits
                            .where((element) => produitsid.contains(element.id))
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCategoryGrid(
                                publication: publication[index],
                                nombreArticles:
                                    publication[index].productIds!.length,
                                produits: produits.sublist(0,
                                    produits.length >= 8 ? 8 : produits.length),
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
      ),
    );
  }
}
