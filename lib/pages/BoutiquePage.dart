import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controllers.dart/appController.dart';
import '../models/StandarPublication.dart';
import '../models/productModels.dart';
import '../widget/buildCategoryGrid.dart';

class BoutiquePage extends StatefulWidget {
  @override
  State<BoutiquePage> createState() => _BoutiquePageState();
}

class _BoutiquePageState extends State<BoutiquePage> {
  int _currentPage = 0;
  // PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    // Initialisez vos données ici si nécessaire
  }

  @override
  Widget build(BuildContext context) {
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
                bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 70),
                  child: Container(
                    alignment: Alignment.center,
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
                              // _pageController.jumpToPage(_currentPage);
                            },
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: _currentPage == 0
                                        ? Colors.red
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Publications',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentPage = 1;
                              });
                              // _pageController.jumpToPage(_currentPage);
                            },
                            child: Container(
                              height: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: _currentPage == 1
                                        ? Colors.red
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Catalogue',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                expandedHeight: 200,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
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
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 100,
                            width: 110,
                            imageUrl: repositoryController
                                .allproduits[8].images!.first,
                          ),
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
                  Expanded(
                    child: IndexedStack(
                      index: _currentPage,
                      children: const [
                        Page1(),
                        Page2(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                final List<PublicationStandard> publications = snapshot.data!
                    .where((element) => element.productIds!.isNotEmpty)
                    .toList();

                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: publications.length,
                  itemBuilder: (context, index) {
                    List<String> produitIds = publications[index].productIds!;
                    List<Produit> produits = repositoryController.allproduits
                        .where((element) => produitIds.contains(element.id))
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCategoryGrid(
                          publication: publications[index],
                          nombreArticles:
                              publications[index].productIds!.length,
                          produits: produits,
                          title: '',
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<List<Produit>>(
            stream: repositoryController.allproduct(),
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
                final List<Produit> produits = snapshot.data!;
                Map<String, List<Produit>> produitsParCategorie = {};

                for (var produit in produits) {
                  if (!produitsParCategorie.containsKey(produit.categorie!)) {
                    produitsParCategorie[produit.categorie!] = [];
                  }
                  produitsParCategorie[produit.categorie!]!.add(produit);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: produitsParCategorie.length,
                  itemBuilder: (context, index) {
                    String categorie =
                        produitsParCategorie.keys.elementAt(index);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCategoryGrid(
                          nombreArticles: 8,
                          produits: produitsParCategorie[categorie]!,
                          title: categorie,
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
