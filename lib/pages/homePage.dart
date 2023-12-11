import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/ProdicPromoPage.dart';
import 'package:shopapp/pages/ProducDetails.dart';
import 'package:shopapp/pages/allCategories.dart';
import 'package:shopapp/pages/historiquePage.dart';
import 'package:shopapp/pages/publication.dart';
import 'package:shopapp/widget/producItem.dart';
import 'package:shopapp/widget/showDialog.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'assets/pub.jpg',
    'assets/pub1.jpg',
  ];
  final List<String> image2 = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
    'assets/10.jpg',
    'assets/11.jpg',
  ];

  final List<String> categories = [
    'Tous',
    'Nouveautés',
    'Populaires',

    'Promotions',
    // 'Électronique',
    // 'Vêtements',
    // 'Alimentation',
    // 'Maison',
    // 'Chicha',
    // 'Telephone'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/taylor2.png',
          height: 170,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5.5,
                child: CarouselSlider(
                  items: images.map((image) {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Détails de la Promotion',
                                  style: GoogleFonts.acme(),
                                ),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      image,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Text(
                                        'Faites vite pour acheter tant qu \'elle est encore valide'),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return SelectionProduitsPromotionPage();
                                        }));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Produits en promotions',
                                            style: GoogleFonts.acme(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Fermer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        ));
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: categories.length,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorWeight: 3,
                        indicatorColor: Colors.orange,
                        isScrollable: true, enableFeedback: true,
                        labelColor: Colors.black,
                        labelStyle:
                            GoogleFonts.acme(fontSize: 16, color: Colors.black),
                        // indicator: ,
                        tabs: categories.map((category) {
                          return Tab(
                            text: category,
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: categories.map((category) {
                            return StreamBuilder<List<Produit>>(
                                stream: repositoryController.allproduct(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  List<Produit> produits = snapshot.data!
                                      .where((element) =>
                                          element.estNouveau == true &&
                                              category == 'Nouveautés' ||
                                          element.estPopulaire == true &&
                                              category == 'Populaires')
                                      .toList();
                                  List<Produit> produits1 = snapshot.data!;
                                  return GridView.builder(
                                    physics: const ScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics())),
                                    padding: category == 'Promotions'
                                        ? const EdgeInsets.all(7)
                                        : const EdgeInsets.all(2),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      mainAxisExtent:
                                          category == 'Promotions' ? 200 : 182,
                                      crossAxisCount: category == 'Promotions'
                                          ? 1
                                          : 2, // Nombre de colonnes
                                    ),
                                    itemCount: category != 'Promotions'
                                        ? produits.isEmpty
                                            ? produits1.length
                                            : produits.length
                                        : 2, // Nombre d'éléments dans la grille
                                    itemBuilder: (context, index) {
                                      Produit produit = produits.isEmpty
                                          ? produits1[index]
                                          : produits[index];
                                      return category != 'Promotions'
                                          ? ProduitGridItem(
                                              image: produit.images!,
                                              nom: produit.nom!,
                                              prix: produit.prix!,
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return DetailsPage(
                                                    produit: produit,
                                                  );
                                                }));
                                              },
                                              onlongpressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ProductOptionsDialog(
                                                        produit: produit);
                                                  },
                                                );
                                              },
                                            )
                                          : Stack(
                                              children: [
                                                Image.asset(
                                                  images[index],
                                                  // width: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                                Positioned(
                                                    right: 5,
                                                    bottom: 5,
                                                    child: Card(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.green,
                                                          // borderRadius:
                                                          //     BorderRadius.all(
                                                          //         Radius.circular(
                                                          //             10))
                                                        ),
                                                        child: const Text(
                                                          'Expire dans 10 jours',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            );
                                    },
                                  );
                                });
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
