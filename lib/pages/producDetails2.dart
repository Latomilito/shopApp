import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../controllers.dart/appController.dart';
import '../models/productModels.dart';
import 'CategorieVendeur.dart';
import 'ComSheet.dart';
import 'allCategories.dart';

// ignore: must_be_immutable
class DetailsPage2 extends StatefulWidget {
  Produit? produit;
  bool? isFromCategorie;
  DetailsPage2({super.key, this.produit, this.isFromCategorie});

  @override
  State<DetailsPage2> createState() => _HistorieState();
}

class _HistorieState extends State<DetailsPage2> {
  int quantity = 1;
  TextEditingController textcontroller = TextEditingController();
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Produit> produitsCategorie = repositoryController.allproduits
        .where((elemet) =>
            elemet.categorie == widget.produit!.categorie &&
            elemet.id != widget.produit!.id)
        .toList();
    List<String> categorieTile = categoriesSet
        .toList()
        .where((elemet) => elemet != widget.produit!.categorie)
        .toList();
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.2,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Center(
                                            child: CachedNetworkImage(
                                                imageUrl: widget
                                                    .produit!.images!.first),
                                          ),
                                        );
                                      }));
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height /
                                          //     2.5,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              widget.produit!.images!.first),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  padding: EdgeInsets.zero,
                                                  shape: const CircleBorder()),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_rounded,
                                                color: Colors.red,
                                              )),
                                          const Spacer(),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  padding: EdgeInsets.zero,
                                                  shape: const CircleBorder()),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.produit!.nom == ''
                                          ? widget.produit!.categorie!
                                          : widget.produit!.nom!,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      widget.produit!.prix!.toInt().toString(),
                                      style: const TextStyle(
                                          backgroundColor: Colors.white,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                      child: const Card(
                                          color: Colors.white,
                                          margin: EdgeInsets.zero,
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                            size: 30,
                                          )),
                                    ),
                                    Card(
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 3),
                                        child: Text(
                                          quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      child: const Card(
                                          color: Colors.white,
                                          margin: EdgeInsets.zero,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.red,
                                            size: 30,
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                widget.produit!.description ??
                                    'Quand deux corps sont présents, celui qui perd de la chaleur au profit de l\'autre est celui des deux qui est à la plus haute température',
                                // widget.produit!.description ?? '',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.grey),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    IconButton(
                                        // Use the EvaIcons class for the IconData
                                        icon: const Icon(EvaIcons.heartOutline),
                                        onPressed: () {
                                          print("Eva Icon heart Pressed");
                                        }),
                                    const Positioned(
                                      bottom: 10,
                                      right: 0,
                                      child: Text(
                                        '+300',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                        // Use the EvaIcons class for the IconData
                                        icon: const Icon(
                                            EvaIcons.messageCircleOutline),
                                        onPressed: () {
                                          showProductBottomSheet(
                                            context,
                                          );
                                          print("Eva Icon heart Pressed");
                                        }),
                                    const Positioned(
                                      bottom: 10,
                                      right: 0,
                                      child: Text(
                                        '+40',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    // Use the EvaIcons class for the IconData
                                    icon: const Icon(EvaIcons.shareOutline),
                                    onPressed: () {
                                      print("Eva Icon heart Pressed");
                                    }),
                              ],
                            ),
                            if (!widget.isFromCategorie!)
                              const Row(
                                children: [
                                  Text(
                                    'Produits similaires',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (!widget.isFromCategorie!)
                        SizedBox(
                          // height: 100,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: produitsCategorie
                                    .sublist(
                                        0,
                                        produitsCategorie.length >= 4
                                            ? 4
                                            : produitsCategorie.length)
                                    .map((element) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              produitsCategorie
                                                          .indexOf(element) !=
                                                      3
                                                  ? Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                      return DetailsPage2(
                                                        isFromCategorie: false,
                                                        produit: element,
                                                      );
                                                    }))
                                                  : Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                      return CategorieVendeur(
                                                        categorieSelected:
                                                            widget.produit!
                                                                .categorie,
                                                      );
                                                    }));
                                            },
                                            child: produitsCategorie
                                                        .indexOf(element) !=
                                                    3
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        '6000 FCFA',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 85,
                                                          width: 85,
                                                          imageUrl: element
                                                              .images!.first,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      const Text(
                                                        '',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              height: 85,
                                                              width: 85,
                                                              imageUrl: element
                                                                  .images!
                                                                  .first,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 85,
                                                            height: 85,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10))),
                                                            child: Text(
                                                              '+${produitsCategorie.length - 3} ',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text(
                              'd\'autres catégories',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 100,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: categorieTile
                                .sublist(
                                    0,
                                    categorieTile.length >= 4
                                        ? 4
                                        : categorieTile.length)
                                .map((element) {
                              Produit produit = repositoryController.allproduits
                                  .firstWhere((element1) =>
                                      element1.categorie == element);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    categorieTile.indexOf(element) != 3
                                        ? Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                            return CategorieVendeur(
                                              categorieSelected: element,
                                            );
                                          }))
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                            return const AllcategoriesPage();
                                          }));
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 85,
                                          width: 85,
                                          imageUrl: produit.images!.first,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        alignment: Alignment.center,
                                        height: 85,
                                        width: 85,
                                        child:
                                            categorieTile.indexOf(element) != 3
                                                ? Text(
                                                    produit.categorie!,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  )
                                                : Text(
                                                    '+${categorieTile.length - 3} ',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  )))
                ])),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // height: 100,
              width: double.infinity,
              // color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                      child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: TextField(
                        controller: textcontroller,
                        onChanged: (query) {
                          setState(() {
                            // filterQuery = query;
                            // categorieSelected = null;
                            // selectedindex = null;
                          });
                        },
                        decoration: InputDecoration(
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            hintText: 'donne une instruction particuliére',
                            border: InputBorder.none),
                      ),
                    ),
                  )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          shape: const CircleBorder()),
                      onPressed: () {
                        cartController.addProductToCart(
                            [widget.produit!],
                            context,
                            quantity,
                            textcontroller.text.isEmpty
                                ? ''
                                : textcontroller.text.trim());
                      },
                      child: const Icon(
                        Icons.shopify_rounded,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ],
        )
      ],
    )));
  }
}
