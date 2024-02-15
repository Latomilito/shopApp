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
  int? selectedTaileIndex;
  int? selectedCouleurIndex;
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
    List<String> taille = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
    List<String> Couleurs = ['Rouge', 'Blanc', 'Noir', 'Jaune', 'Vert', 'Blue'];
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
            bottomNavigationBar: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.green,
                    child: const Text(
                      'Acheter mainenant',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      cartController.addProductToCart(
                          [widget.produit!],
                          context,
                          quantity,
                          textcontroller.text.isEmpty
                              ? ''
                              : textcontroller.text.trim());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: Colors.red,
                      child: const Text(
                        'Ajouter au panier',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            body: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return Scaffold(
                                              body: Center(
                                                child: CachedNetworkImage(
                                                    imageUrl: widget.produit!
                                                        .images!.first),
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
                                              imageUrl: widget
                                                  .produit!.images!.first),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.produit!.nom == ''
                                                  ? widget.produit!.categorie!
                                                  : widget.produit!.nom!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              widget.produit!.prix!
                                                  .toInt()
                                                  .toString(),
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
                                                    color: Colors.black,
                                                    size: 30,
                                                  )),
                                            ),
                                            Card(
                                              elevation: 0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 3),
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
                                                    color: Colors.black,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        widget.produit!.description ??
                                            'Quand deux corps sont présents, celui qui perd de la chaleur au profit de l\'autre est celui des deux qui est à la plus haute température',
                                        // widget.produit!.description ?? '',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                      ),
                                    ),
                                    const Row(children: [
                                      Text(
                                        'Boutique',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Sana\'s market',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              width: 1,
                                              color: Colors.grey,
                                              height: 10,
                                            ),
                                            const Row(children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                                color: Colors.grey,
                                              ),
                                              Text('Niamey'),
                                            ])
                                          ],
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            IconButton(
                                                // Use the EvaIcons class for the IconData
                                                icon: const Icon(
                                                    EvaIcons.heartOutline),
                                                onPressed: () {
                                                  print(
                                                      "Eva Icon heart Pressed");
                                                }),
                                            const Positioned(
                                              bottom: 10,
                                              right: 0,
                                              child: Text(
                                                '+300',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            IconButton(
                                                // Use the EvaIcons class for the IconData
                                                icon: const Icon(EvaIcons
                                                    .messageCircleOutline),
                                                onPressed: () {
                                                  showProductBottomSheet(
                                                    context,
                                                  );
                                                  print(
                                                      "Eva Icon heart Pressed");
                                                }),
                                            const Positioned(
                                              bottom: 10,
                                              right: 0,
                                              child: Text(
                                                '+40',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Card(
                                      elevation: 0,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tailles',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Wrap(
                                                children: taille.map((e) {
                                                  int index = taille.indexOf(e);
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedTaileIndex =
                                                            index;
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: selectedTaileIndex !=
                                                                          null &&
                                                                      taille[selectedTaileIndex!] ==
                                                                          e
                                                                  ? Colors
                                                                      .transparent
                                                                  : Colors
                                                                      .grey),
                                                          color: selectedTaileIndex !=
                                                                      null &&
                                                                  taille[selectedTaileIndex!] ==
                                                                      e
                                                              ? Colors.red
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      5))),
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            color: selectedTaileIndex !=
                                                                        null &&
                                                                    taille[selectedTaileIndex!] ==
                                                                        e
                                                                ? Colors.white
                                                                : Colors.grey,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Couleurs',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Wrap(
                                                  children: Couleurs.map((e) {
                                                    int index =
                                                        Couleurs.indexOf(e);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCouleurIndex =
                                                              index;
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: selectedCouleurIndex !=
                                                                            null &&
                                                                        Couleurs[selectedCouleurIndex!] ==
                                                                            e
                                                                    ? Colors
                                                                        .transparent
                                                                    : Colors
                                                                        .grey),
                                                            color: selectedCouleurIndex !=
                                                                        null &&
                                                                    Couleurs[selectedCouleurIndex!] ==
                                                                        e
                                                                ? Colors.red
                                                                : Colors
                                                                    .transparent,
                                                            borderRadius:
                                                                const BorderRadius.all(
                                                                    Radius.circular(
                                                                        5))),
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: selectedCouleurIndex !=
                                                                          null &&
                                                                      Couleurs[
                                                                              selectedCouleurIndex!] ==
                                                                          e
                                                                  ? Colors.white
                                                                  : Colors.grey,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!widget.isFromCategorie!)
                                      Row(
                                        children: [
                                          const Text(
                                            'Produits similaires',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return CategorieVendeur(
                                                  categorieSelected:
                                                      widget.produit!.categorie,
                                                );
                                              }));
                                            },
                                            child: const Text('voir plus'),
                                          )
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: produitsCategorie
                                            .sublist(
                                                0,
                                                produitsCategorie.length >= 8
                                                    ? 8
                                                    : produitsCategorie.length)
                                            .map((element) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        produitsCategorie.indexOf(
                                                                    element) !=
                                                                7
                                                            ? Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(builder:
                                                                    (BuildContext
                                                                        context) {
                                                                return DetailsPage2(
                                                                  isFromCategorie:
                                                                      false,
                                                                  produit:
                                                                      element,
                                                                );
                                                              }))
                                                            : Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(builder:
                                                                    (BuildContext
                                                                        context) {
                                                                return CategorieVendeur(
                                                                  categorieSelected: widget
                                                                      .produit!
                                                                      .categorie,
                                                                );
                                                              }));
                                                      },
                                                      child: produitsCategorie
                                                                  .indexOf(
                                                                      element) !=
                                                              7
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                  '6000 FCFA',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2.4,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        3,
                                                                    imageUrl: element
                                                                        .images!
                                                                        .first,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox()),
                                                ))
                                            .toList()),
                                  ),
                                ),
                              if (!widget.isFromCategorie!)
                                Row(
                                  children: [
                                    const Text(
                                      ' Populaires',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return CategorieVendeur(
                                            categorieSelected:
                                                widget.produit!.categorie,
                                          );
                                        }));
                                      },
                                      child: const Text('voir plus'),
                                    )
                                  ],
                                ),

                              SizedBox(
                                // height: 100,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: produitsCategorie
                                          .sublist(
                                              0,
                                              produitsCategorie.length >= 8
                                                  ? 8
                                                  : produitsCategorie.length)
                                          .map((element) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      produitsCategorie.indexOf(
                                                                  element) !=
                                                              7
                                                          ? Navigator.of(
                                                                  context)
                                                              .push(MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                              return DetailsPage2(
                                                                isFromCategorie:
                                                                    false,
                                                                produit:
                                                                    element,
                                                              );
                                                            }))
                                                          : Navigator.of(
                                                                  context)
                                                              .push(MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                              return CategorieVendeur(
                                                                categorieSelected:
                                                                    widget
                                                                        .produit!
                                                                        .categorie,
                                                              );
                                                            }));
                                                    },
                                                    child: produitsCategorie
                                                                .indexOf(
                                                                    element) !=
                                                            7
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                '6000 FCFA',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.4,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3,
                                                                  imageUrl: element
                                                                      .images!
                                                                      .first,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox()),
                                              ))
                                          .toList()),
                                ),
                              ),
                              // SizedBox(
                              //   // height: 100,
                              //   child: SingleChildScrollView(
                              //     scrollDirection: Axis.horizontal,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: categorieTile
                              //           .sublist(
                              //               0,
                              //               categorieTile.length >= 4
                              //                   ? 4
                              //                   : categorieTile.length)
                              //           .map((element) {
                              //         Produit produit = repositoryController.allproduits
                              //             .firstWhere((element1) =>
                              //                 element1.categorie == element);
                              //         return Padding(
                              //           padding:
                              //               const EdgeInsets.symmetric(horizontal: 5),
                              //           child: GestureDetector(
                              //             onTap: () {
                              //               categorieTile.indexOf(element) != 3
                              //                   ? Navigator.of(context).push(
                              //                       MaterialPageRoute(builder:
                              //                           (BuildContext context) {
                              //                       return CategorieVendeur(
                              //                         categorieSelected: element,
                              //                       );
                              //                     }))
                              //                   : Navigator.of(context).push(
                              //                       MaterialPageRoute(builder:
                              //                           (BuildContext context) {
                              //                       return const AllcategoriesPage();
                              //                     }));
                              //             },
                              //             child: Stack(
                              //               children: [
                              //                 ClipRRect(
                              //                   borderRadius: BorderRadius.circular(10),
                              //                   child: CachedNetworkImage(
                              //                     height: 85,
                              //                     width: 85,
                              //                     imageUrl: produit.images!.first,
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //                 Container(
                              //                   decoration: BoxDecoration(
                              //                       color:
                              //                           Colors.black.withOpacity(0.6),
                              //                       borderRadius:
                              //                           const BorderRadius.all(
                              //                               Radius.circular(10))),
                              //                   alignment: Alignment.center,
                              //                   height: 85,
                              //                   width: 85,
                              //                   child:
                              //                       categorieTile.indexOf(element) != 3
                              //                           ? Text(
                              //                               produit.categorie!,
                              //                               textAlign: TextAlign.center,
                              //                               style: const TextStyle(
                              //                                   color: Colors.white,
                              //                                   fontSize: 17),
                              //                             )
                              //                           : Text(
                              //                               '+${categorieTile.length - 3} ',
                              //                               style: const TextStyle(
                              //                                   color: Colors.white,
                              //                                   fontSize: 20),
                              //                             ),
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       }).toList(),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 100,
                              // )
                            ],
                          )))
                        ])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
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
                              color: Colors.black,
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
                              Icons.favorite_border,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    const Spacer(),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //   // height: 100,
                    //   width: double.infinity,

                    //   decoration: const BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     color: Colors.black,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: Card(
                    //         shape: const RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.all(Radius.circular(10))),
                    //         elevation: 0,
                    //         child: ClipRRect(
                    //           borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //           child: TextField(
                    //             controller: textcontroller,
                    //             onChanged: (query) {
                    //               setState(() {
                    //                 // filterQuery = query;
                    //                 // categorieSelected = null;
                    //                 // selectedindex = null;
                    //               });
                    //             },
                    //             decoration: InputDecoration(
                    //                 // focusedBorder: InputBorder.none,
                    //                 // enabledBorder: InputBorder.none,
                    //                 fillColor: Colors.grey.withOpacity(0.2),
                    //                 filled: true,
                    //                 hintText: 'donne une instruction particuliére',
                    //                 border: InputBorder.none),
                    //           ),
                    //         ),
                    //       )),
                    //       ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               elevation: 2,
                    //               backgroundColor: Colors.white,
                    //               padding: const EdgeInsets.all(10),
                    //               shape: const CircleBorder()),
                    //           onPressed: () {
                    //             cartController.addProductToCart(
                    //                 [widget.produit!],
                    //                 context,
                    //                 quantity,
                    //                 textcontroller.text.isEmpty
                    //                     ? ''
                    //                     : textcontroller.text.trim());
                    //           },
                    //           child: const Icon(
                    //             Icons.shopify_rounded,
                    //             color: Colors.red,
                    //           ))
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            )));
  }
}
