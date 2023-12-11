import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/pages/historiPage.dart';
import 'package:shopapp/pages/home2.dart';
import 'package:shopapp/pages/producDetails2.dart';
import 'package:shopapp/pages/produitdetails3.dart';
import 'package:shopapp/utility/Utility.dart';

import '../models/productModels.dart';
import '../pages/ComSheet.dart';
import '../pages/ProducDetails.dart';
import '../pages/histori.dart';

class buildCategoryGrid extends StatefulWidget {
  final List<Produit> produits;
  final String title;
  PublicationStandard? publication;
  final int nombreArticles;
  final Widget? pageToOpen; // Nouveau paramètre

  buildCategoryGrid({
    this.publication,
    required this.produits,
    required this.title,
    this.nombreArticles = 8,
    this.pageToOpen, // Ajout du nouveau paramètre
  });

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<buildCategoryGrid> {
  void _showGridViewDialog(List<Produit> produits, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GridViewDialog(
          produits: produits,
          initialIndex: initialIndex,
          description: widget.publication!.description!,
        );
      },
    );
  }

  List<Produit>? produitsMelange;
  final PageController _pageController = PageController();
  int pageindex = 0;

  @override
  void initState() {
    super.initState();
    produitsMelange = widget.produits;
  }

  @override
  Widget build(BuildContext context) {
    produitsMelange!.shuffle();
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight <= 600;

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return DetailsPage3(
            publication: widget.publication,
            produits: widget.produits,
          );
        }));
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.grey.withOpacity(0.2),
        // color: Colors.orangeAccent.withOpacity(0.2),
        // elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 8,
              right: widget.title != '' ? 0 : 8,
              left: widget.title != '' ? 0 : 8),
          child: Column(
            children: [
              // Divider(),
              widget.publication == null
                  ? buildCategorySection(
                      title: widget.title,
                    )
                  : buildCategorySection(
                      title: widget.title, publication: widget.publication!),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.nombreArticles % 2 == 0
                      ? (widget.nombreArticles == 2
                          ? widget.nombreArticles
                          : widget.nombreArticles ~/ 2)
                      : (widget.nombreArticles == 1
                          ? widget.nombreArticles
                          : widget.nombreArticles == 3
                              ? widget.nombreArticles
                              : ((widget.nombreArticles + 1) ~/ 2)),
                ),
                itemCount: produitsMelange!.length >= widget.nombreArticles
                    ? produitsMelange!.sublist(0, widget.nombreArticles).length
                    : produitsMelange!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.publication != null
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                              return DetailsPage3(
                                produits: widget.produits,
                                publication: widget.publication,
                              );
                            }))
                          // ? Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //     return Historie(
                          //       isStory: false,
                          //       index1: index,
                          //       pageController:
                          //           PageController(initialPage: index),
                          //       publications: [widget.publication!],
                          //       produit: produitsMelange,
                          //     );
                          //   }))
                          // ? _showGridViewDialog(produitsMelange!, index)
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  // return ProductDetails2(
                                  //   produits: produitsMelange,
                                  //   produit: produitsMelange!.length >= 8
                                  //       ? produitsMelange!.sublist(0, 8)[index]
                                  //       : produitsMelange![index],
                                  // );

                                  return DetailsPage(
                                    produit: produitsMelange!.length >= 8
                                        ? produitsMelange!.sublist(0, 8)[index]
                                        : produitsMelange![index],
                                  ); // Utilisez le paramètre pour déterminer quelle page ouvrir
                                },
                              ),
                            );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      color: Colors.grey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: double.maxFinite,
                          width: double.infinity,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Colors.grey.withOpacity(0.2),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          imageUrl:
                              produitsMelange!.length >= widget.nombreArticles
                                  ? produitsMelange!
                                      .sublist(0, widget.nombreArticles)[index]
                                      .images!
                                      .first
                                  : produitsMelange![index].images!.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection(
      {String? title, PublicationStandard? publication}) {
    return Container(
      // margin: const EdgeInsets.only(top: 5),
      // padding: const EdgeInsets.only(left: 7),
      width: double.infinity,
      // color: Colors.grey.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title == '')
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(360)),
                  child: CachedNetworkImage(
                      height: 20,
                      width: 20,
                      imageUrl:
                          repositoryController.allproduits.first.images!.first),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return home();
                    }));
                  },
                  child: const Text(
                    'Sana\'s market',
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                ),
                const Spacer(),
                // const Icon(
                //   Icons.favorite_border,
                //   color: Colors.orange,
                // ),
                // const SizedBox(
                //   width: 5,
                // ),
                // IconButton(
                //     onPressed: () {
                //       showProductCommentsBottomSheet(context, 'Nom du produit');
                //     },
                //     icon: const Icon(
                //       Icons.mode_comment_outlined,
                //       color: Colors.orange,
                //     ))
              ],
            ),
          // SizedBox(
          //   height: 5,
          // ),
          if (title != '')
            Container(
              // margin: const EdgeInsets.only(top: 7),
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.grey.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          // ignore: unnecessary_null_comparison
          if (publication != null)
            Text(
              publication.description!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          if (publication != null)
            Text(
              '${Utilities.getDayName(publication.date!.weekday)} le ${publication.date!.day} ${Utilities.getMonthName(publication.date!.month)} à ${publication.date!.hour}h ${publication.date!.minute}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class GridViewDialog extends StatefulWidget {
  final List<Produit> produits;
  final int initialIndex;
  String? description;
  GridViewDialog(
      {required this.produits, required this.initialIndex, this.description});

  @override
  _GridViewDialogState createState() => _GridViewDialogState();
}

class _GridViewDialogState extends State<GridViewDialog> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // margin: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height /
            1.7, // Ajustez la hauteur selon vos besoins
        // width: 300, // Ajustez la largeur selon vos besoins
        child: Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: widget.produits.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    YourGridViewItemWidget(
                      index: index,
                      produits: widget.produits,
                      pageController: _pageController,
                      description: widget.description!,
                      produit: widget.produits[index],
                      onMiniatureTap: () {
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class YourGridViewItemWidget extends StatefulWidget {
  final Produit produit;
  final VoidCallback onMiniatureTap;
  String? description;
  PageController? pageController;
  int? index;
  List<Produit>? produits;

  YourGridViewItemWidget(
      {required this.produit,
      this.produits,
      required this.onMiniatureTap,
      this.description,
      this.index,
      this.pageController});

  @override
  State<YourGridViewItemWidget> createState() => _YourGridViewItemWidgetState();
}

class _YourGridViewItemWidgetState extends State<YourGridViewItemWidget> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    bool isAdd = authController.usermodel.value.cartList!
        .any((element) => element.productId == widget.produit.id);

    return Container(
        // padding: EdgeInsets.all(10),
        // height: MediaQuery.of(context).size.height / 2,
        // Widget pour représenter les éléments de la PageView
        // Utilisez les détails de produit pour personnaliser cette partie
        child: Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(360)),
              child: CachedNetworkImage(
                  height: 20,
                  width: 20,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Text(
                widget.produit.categorie!,
                style: const TextStyle(color: Colors.orange, fontSize: 17),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return DetailsPage(
                      produit: widget.produit,
                    );
                  }));
                },
                child: const Text('Plus d\'articles..'),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.2,
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.2,
                imageUrl: widget.produit.images!.first,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          if (widget.index != 0)
                            GestureDetector(
                              onTap: () {
                                widget.pageController!
                                    .jumpToPage(widget.index! - 1);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60))),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.orange,
                                    size: 25,
                                  )),
                            ),
                          const Spacer(),
                          if (widget.index != widget.produits!.length - 1)
                            GestureDetector(
                              onTap: () {
                                widget.pageController!
                                    .jumpToPage(widget.index! + 1);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60))),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.orange,
                                    size: 25,
                                  )),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Text(
                '5000 FCFA',
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.remove,
                  )),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                  ))
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.favorite_border,
              //       color: Colors.orange,
              //     )),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.messenger_outline,
              //       color: Colors.orange,
              //     ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(widget.produit.description ?? widget.description!),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isAdd ? Colors.grey : Colors.orange,
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            isAdd
                ? null
                : cartController
                    .addProductToCart([widget.produit], context, quantity);
          },
          child: isAdd
              ? const Text(
                  'Déja au panier',
                )
              : const Text(
                  'Ajouter au panier',
                ),
        )
      ],
    ));
  }
}
