import 'package:flutter/material.dart';
import 'package:shopapp/models/productModels.dart';

import '../controllers.dart/appController.dart';
import '../widget/producItem.dart';
import 'ProducDetails.dart';

class AllcategoriesPage extends StatefulWidget {
  const AllcategoriesPage({super.key});

  @override
  State<AllcategoriesPage> createState() => _AllcategoriesPageState();
}

class _AllcategoriesPageState extends State<AllcategoriesPage> {
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
    'Électronique',
    'Vêtements',
    'Alimentation',
    'Maison',
    'Chicha',
    'Telephone'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
                      // indicator: ,
                      tabs: categories.map((category) {
                        return Tab(text: category);
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
                                  return Container();
                                }
                                List<Produit> produits = snapshot.data!
                                    .where((element) =>
                                        element.categorie == category)
                                    .toList();
                                return GridView.builder(
                                  physics: const ScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics())),
                                  padding: const EdgeInsets.all(2),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    crossAxisCount:
                                        category == 'Promotions' ? 1 : 2,
                                  ),
                                  itemCount: produits.length,
                                  itemBuilder: (context, index) {
                                    Produit produit = produits[index];
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
                                            onlongpressed: () {},
                                          )
                                        : const Card(
                                            elevation: 5,
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
    );
  }
}
