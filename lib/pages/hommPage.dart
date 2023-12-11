import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/commandeInfo.dart';
import 'package:shopapp/pages/histori.dart';
import 'package:shopapp/pages/historiPage.dart';
import 'package:shopapp/pages/home2.dart';
import 'package:story_view/story_view.dart';

import '../controllers.dart/appController.dart';
import '../widget/buildCategoryGrid.dart';
import '../widget/promotionSlider.dart';
import 'ProducDetails.dart';

class Home5 extends StatefulWidget {
  const Home5({super.key});

  @override
  State<Home5> createState() => _Home5State();
}

class _Home5State extends State<Home5> {
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

  List<Produit> allproduits = repositoryController.allproduits;

  @override
  Widget build(BuildContext context) {
    allproduits.shuffle();
    final List<String> images = [
      'assets/pub.jpg',
      'assets/pub1.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Soft Store',
          style: TextStyle(
            color: Colors.orange,
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
              color: Colors.orange,
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            // // Padding(
            // //   padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
            // //   child: SliderPromotion(
            // //     images: images,
            // //   ),
            // // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Text('History'),
            // Container(
            //   margin: const EdgeInsets.only(left: 15),
            //   child: const Row(
            //     children: [
            //       Text(
            //         'Histori',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: SizedBox(
                height: 85,
                child: StreamBuilder<List<PublicationStandard>>(
                  stream: repositoryController.allpublication(),
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
                      final List<PublicationStandard> publication = snapshot
                          .data!
                          .where((element) => element.productIds!.isNotEmpty)
                          .toList();
                      List<Produit> produitsDujout = [];
                      for (var i = 0; i < publication.length; i++) {
                        for (var a = 0;
                            a < publication[i].productIds!.length;
                            a++) {
                          produitsDujout.add(repositoryController.allproduits
                              .firstWhere((element) =>
                                  element.id == publication[i].productIds![a]));
                        }
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            4,
                            (index) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return Historie(
                                            isStory: true,
                                            index1: 0,
                                            pageController:
                                                PageController(initialPage: 0),
                                            publications: publication,
                                            produit: produitsDujout,
                                          );
                                        }));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: Colors.orange,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(360)),
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.orange)),
                                        padding: const EdgeInsets.all(3),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(360)),
                                          child: CachedNetworkImage(
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                              imageUrl: repositoryController
                                                  .allproduits
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      publication.first
                                                          .productIds!.first)
                                                  .images!
                                                  .first),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text('Sana\'s market'),
                                  ],
                                )),
                      );
                    }
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                elevation: 0,
                color: Colors.grey.withOpacity(0.2),
                child: Column(
                  children: [
                    // Container(
                    //   color: Colors.grey.withOpacity(0.2),
                    //   margin: const EdgeInsets.only(left: 15, right: 15),
                    //   child: const Row(
                    //     children: [
                    //       Text(
                    //         'Catégories',
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //       Spacer(),
                    //       Text('voir plus')
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5.5,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
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
                              onCategorySelected(categorie);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 3),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width:
                                          MediaQuery.of(context).size.height *
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
                                    categorie,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
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
                  ],
                ),
              ),
            ),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: List.generate(8, (index) {
            //           Produit produit = repositoryController.allproduits
            //               .firstWhere(
            //                   (element) => element.categorie == 'Parfums');
            //           return GestureDetector(
            //             onTap: () {
            //               Navigator.of(context).push(MaterialPageRoute(
            //                   builder: (BuildContext context) {
            //                 return home();
            //               }));
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.only(
            //                   bottom: 10, top: 5, left: 5, right: 5),
            //               margin: const EdgeInsets.symmetric(horizontal: 5),
            //               height: 120,
            //               width: 90,
            //               decoration: BoxDecoration(
            //                   color: Colors.grey.withOpacity(0.2),
            //                   borderRadius:
            //                       const BorderRadius.all(Radius.circular(10))),
            //               child: Column(
            //                 children: [
            //                   Expanded(
            //                     child: ClipRRect(
            //                       borderRadius: const BorderRadius.all(
            //                           Radius.circular(360)),
            //                       child: CachedNetworkImage(
            //                         imageUrl: produit.images!.first,
            //                         fit: BoxFit.cover,
            //                       ),
            //                     ),
            //                   ),
            //                   // const SizedBox(
            //                   //   height: ,
            //                   // ),
            //                   const Card(
            //                     elevation: 2,
            //                     color: Colors.blue,
            //                     shape: RoundedRectangleBorder(
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(10))),
            //                     margin:
            //                         EdgeInsets.only(top: 5, right: 2, left: 2),
            //                     child: Padding(
            //                       padding: EdgeInsets.all(4),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             'S\'abonné',
            //                             style: TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                           Icon(
            //                             Icons.add,
            //                             color: Colors.white,
            //                             size: 18,
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         }),
            //       ),
            //     )),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Row(
                children: [
                  Text(
                    'Publications',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<PublicationStandard>>(
              stream: repositoryController.allpublication(),
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
                      List<String> produitsid = publication[index].productIds!;
                      List<Produit> produits = repositoryController.allproduits
                          .where((element) => produitsid.contains(element.id))
                          .toList();
                      // String categorie =
                      //     produitsParCategorie.keys.elementAt(index);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // buildCategorySection(categorie),
                          // buildCategoryGrid2(
                          //     creerListeAvecImagesMultiples(
                          //         produitsParCategorie[categorie]!),
                          //     categorie),
                          buildCategoryGrid(
                              publication: publication[index],
                              nombreArticles:
                                  publication[index].productIds!.length,
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
    );
  }
}
