import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/productModels.dart';
import '../controllers.dart/appController.dart';
import 'CategorieVendeur.dart';

class AllcategoriesPage extends StatefulWidget {
  const AllcategoriesPage({super.key});
  @override
  State<AllcategoriesPage> createState() => _AllcategoriesPageState();
}

class _AllcategoriesPageState extends State<AllcategoriesPage> {
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();
  String filterQuery = '';
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Catégories',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                // color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: TextField(
                            onChanged: (query) {
                              setState(() {
                                filterQuery = query;
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
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.start,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return CategorieVendeur(
                                categorieSelected: produit.categorie);
                          }));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 2),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
              )
            ],
          )),
    );
  }
}
