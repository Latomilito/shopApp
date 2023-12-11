import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/cartService.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/offreModel.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/home2.dart';
import 'package:shopapp/pages/imageView.dart';
import 'package:shopapp/pages/producDetails2.dart';
import 'package:shopapp/widget/SliderProduct.dart';
import 'package:shopapp/widget/producItem.dart';
import 'package:shopapp/widget/promotionSlider.dart';

import '../controllers.dart/appController.dart';
import '../widget/VarianteWidget.dart';
import 'historiPage.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(
      {super.key, this.produit, this.quantity = 1, this.categorieCherche});
  Produit? produit;
  int quantity;
  String? categorieCherche;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String onDateSelected(DateTime date) {
    // Formater la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);

    return formattedDate;
  }

  ScrollController _scrollController = ScrollController();
  String selectedColor = '';
  String selectedPointure = '';

  final List<String> couleurs = [
    'FF0000',
    '00FF00',
    '0000FF'
  ]; // Couleurs en format hexadécimal
  final List<String> pointures = [
    '36',
    '38',
    '40',
    '42'
  ]; // Exemple de pointures

  List<int> selectedIndexes = [];
  List<Produit> selectedProducts = [];

  void _scrollToElement() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        200.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Produit? prod;
  String? urlImage;
  int _seletedindex = 0;
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
  final List<String> images = [
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
  ];
  final PageController _pageController = PageController();
  bool isselected = false;
  int _currentPage = 0;
  void initial() {
    if (widget.categorieCherche != null) {
      prod = repositoryController.allproduits
          .where((element) => element.categorie == widget.categorieCherche)
          .toList()
          .first;
    } else {
      repositoryController.allproduits.remove(widget.produit);
      repositoryController.allproduits.insert(0, widget.produit!);
      prod = repositoryController.allproduits
          .where((element) => element.categorie == widget.produit!.categorie)
          .toList()
          .first;
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
    urlImage = widget.categorieCherche != null
        ? repositoryController.allproduits
            .where((element) => element.categorie == widget.categorieCherche)
            .toList()
            .first
            .images!
            .first
        : widget.produit!.images!.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(360)),
              child: CachedNetworkImage(
                  height: 30,
                  width: 30,
                  imageUrl:
                      repositoryController.allproduits.first.images!.first),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return home();
                }));
              },
              child: const Text(
                'Sana\'s market',
                style: TextStyle(color: Colors.orange, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              // SliderProduct(
              //   produit: prod,
              //   urlImage: urlImage,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           prod!.nom == '' ? prod!.categorie! : prod!.nom!,
              //           style:
              //               const TextStyle(fontSize: 18, color: Colors.black),
              //         ),
              //         Text(
              //           prod!.prix == 0.0
              //               ? '5000 FCFA'
              //               : '${prod!.prix!} FCFA ',
              //           style: GoogleFonts.acme(color: Colors.green),
              //         ),
              //       ],
              //     ),
              //     const Spacer(),
              //     if (selectedProducts.isEmpty)
              //       Row(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               if (widget.quantity > 1) {
              //                 setState(() {
              //                   widget.quantity--;
              //                 });
              //               }
              //             },
              //             child: const Card(
              //                 color: Colors.orange,
              //                 margin: EdgeInsets.zero,
              //                 child: Icon(
              //                   Icons.remove,
              //                   color: Colors.white,
              //                   size: 30,
              //                 )),
              //           ),
              //           Card(
              //             margin: EdgeInsets.zero,
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 5, vertical: 3),
              //               child: Text(
              //                 widget.quantity.toString(),
              //                 style: const TextStyle(
              //                   fontSize: 20,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 widget.quantity++;
              //               });
              //             },
              //             child: const Card(
              //                 color: Colors.orange,
              //                 margin: EdgeInsets.zero,
              //                 child: Icon(
              //                   Icons.add,
              //                   color: Colors.white,
              //                   size: 30,
              //                 )),
              //           )
              //         ],
              //       )
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cette catégorie propose une gamme diversifiée de montres pour hommes et femmes',
                            style: GoogleFonts.cardo(fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              // const Text('Produits de la même catégorie'),
              repositoryController.allproduits
                      .where((element) => widget.produit != null
                          ? element.categorie == widget.produit!.categorie
                          : element.categorie == prod!.categorie)
                      .toList()
                      .isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(2),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: widget.produit != null
                            ? repositoryController.allproduits
                                .where((element) =>
                                    element.categorie ==
                                    widget.produit!.categorie)
                                .fold(
                                  0,
                                  (count, produit) =>
                                      count! + produit.images!.length,
                                )
                            : repositoryController.allproduits
                                .where((element) =>
                                    element.categorie == prod!.categorie)
                                .fold(
                                  0,
                                  (count, produit) =>
                                      count! + produit.images!.length,
                                ),
                        itemBuilder: (context, index) {
                          int runningIndex = 0;

                          Produit? produit;
                          int? imageIndex;

                          for (int i = 0;
                              i <
                                  repositoryController.allproduits
                                      .where((element) => widget.produit != null
                                          ? element.categorie ==
                                              widget.produit!.categorie
                                          : element.categorie ==
                                              prod!.categorie)
                                      .length;
                              i++) {
                            int nextIndex = runningIndex +
                                repositoryController.allproduits
                                    .where((element) => widget.produit != null
                                        ? element.categorie ==
                                            widget.produit!.categorie
                                        : element.categorie == prod!.categorie)
                                    .toList()[i]
                                    .images!
                                    .length;
                            if (index < nextIndex) {
                              produit = repositoryController.allproduits
                                  .where((element) => widget.produit != null
                                      ? element.categorie ==
                                          widget.produit!.categorie
                                      : element.categorie == prod!.categorie)
                                  .toList()[i];
                              imageIndex = index - runningIndex;
                              break;
                            } else {
                              runningIndex = nextIndex;
                            }
                          }

                          String imageUrl = produit!.images![imageIndex!];

                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                if (selectedIndexes.contains(index)) {
                                  selectedIndexes.remove(index);
                                  selectedProducts.remove(produit!);
                                  setState(() {});
                                } else {
                                  selectedIndexes.add(index);
                                  selectedProducts.add(produit!);
                                }
                              });
                            },
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return DetailsPage2(
                                  produit: produit!,
                                  isProduiCherche: false,
                                );
                              }));
                              setState(() {
                                _seletedindex = index;
                                prod = produit;
                                urlImage = imageUrl;
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      height: double.maxFinite,
                                      width: double.infinity,
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          color: Colors.grey.withOpacity(0.2),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: double.maxFinite,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: selectedIndexes.contains(index) ||
                                              produit.images!.first ==
                                                  prod!.images!.first
                                          ? Colors.black.withOpacity(0.7)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: selectedIndexes.contains(index)
                                        ? Center(
                                            child: Text(
                                              '${selectedIndexes.indexOf(selectedIndexes.firstWhere((element) => element == index)) + 1}', // Afficher l'index + 1
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )
                                        : null,
                                  )
                                  // : Container(
                                  //     height: double.maxFinite,
                                  //     width: double.infinity,
                                  //     color: produit.images!.first ==
                                  //             prod!.images!.first
                                  //         ? Colors.black.withOpacity(0.7)
                                  //         : Colors.transparent,
                                  //   )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {
                              // CartService().ajouterProduitAuPanier(
                              //     widget.produit.id!, context);

                              selectedProducts.isNotEmpty
                                  ? cartController.addProductToCart(
                                      selectedProducts,
                                      context,
                                      widget.quantity)
                                  : cartController.addProductToCart(
                                      [prod!], context, widget.quantity);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ajouter au panier',
                                  style: GoogleFonts.acme(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return home();
                                }));
                              },
                              child: const Text('Voir la boutique')),
                        )
                      ],
                    ),
                    selectedIndexes.isNotEmpty
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () async {
                              PublicationStandard publication =
                                  PublicationStandard(
                                      id: DateTime.now().toString(),
                                      productIds: selectedProducts
                                          .map((e) => e.id!)
                                          .toList(),
                                      datee: onDateSelected(DateTime.now()),
                                      description: '');
                              await repositoryController
                                  .ajouterPublication(publication, context)
                                  .whenComplete(() {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Produis publés avec succée'),
                                ));
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Action personnalisée',
                                  style: GoogleFonts.acme(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
