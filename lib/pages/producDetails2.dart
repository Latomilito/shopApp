import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/pages/ViewProduit.dart';
import 'package:shopapp/widget/produiWidget.dart';
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

class _HistorieState extends State<DetailsPage2>
    with SingleTickerProviderStateMixin {
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
            bottomSheet: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            elevation: 5,
                            // color: Colors.black,
                            margin: EdgeInsets.zero,
                            // height: 40,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Form(
                              // key: _form,
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                                // focusNode: _focusNode,
                                // validator: ValidationBuilder().required().build(),
                                controller: textcontroller,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText:
                                        'Saisir ici tailles ,couleurs ou autres préference..',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                              ),
                            )),
                      ),
                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         elevation: 5,
                      //         padding: const EdgeInsets.all(10),
                      //         backgroundColor: Colors.black,
                      //         shape: const CircleBorder()),
                      //     onPressed: () {},
                      //     child: const Icon(
                      //       Icons.add,
                      //       color: Colors.white,
                      //       size: 30,
                      //     ))
                    ],
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10))),
                            child: const Text(
                              'Acheter mainenant',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              textcontroller.text.isNotEmpty
                                  ? cartController.addProductToCart(
                                      [widget.produit!], context, quantity,
                                      instruction: textcontroller.text)
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.white,
                                        showCloseIcon: true,
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        // backgroundColor: Colors.red,
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Veillez saisir vos préférence svp ',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10))),
                              child: const Text(
                                'Ajouter au panier',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
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
                                            return ViewProduit(
                                              produits: [widget.produit!],
                                              pageController: PageController(
                                                  initialPage: 0),
                                              quantity: quantity,
                                              prouit: widget.produit!,
                                            );
                                          }));
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0)),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
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
                                                    backgroundColor:
                                                        Colors.white,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            const CircleBorder()),
                                                    onPressed: () {
                                                      if (quantity > 1) {
                                                        setState(() {
                                                          quantity--;
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      quantity.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            const CircleBorder()),
                                                    onPressed: () {
                                                      setState(() {
                                                        quantity++;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
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
                                                      context, this);
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
                                    // Card(
                                    //   elevation: 0,
                                    //   child: Column(
                                    //     children: [
                                    //       const Padding(
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: 10),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.start,
                                    //           children: [
                                    //             Text(
                                    //               'Tailles',
                                    //               style:
                                    //                   TextStyle(fontSize: 16),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           Wrap(
                                    //             children: taille.map((e) {
                                    //               int index = taille.indexOf(e);
                                    //               return GestureDetector(
                                    //                 onTap: () {
                                    //                   setState(() {
                                    //                     selectedTaileIndex =
                                    //                         index;
                                    //                   });
                                    //                 },
                                    //                 child: Container(
                                    //                   margin:
                                    //                       const EdgeInsets.only(
                                    //                           right: 10),
                                    //                   alignment:
                                    //                       Alignment.center,
                                    //                   padding: const EdgeInsets
                                    //                       .symmetric(
                                    //                       horizontal: 15,
                                    //                       vertical: 5),
                                    //                   decoration: BoxDecoration(
                                    //                       border: Border.all(
                                    //                           width: 1,
                                    //                           color: selectedTaileIndex !=
                                    //                                       null &&
                                    //                                   taille[selectedTaileIndex!] ==
                                    //                                       e
                                    //                               ? Colors
                                    //                                   .transparent
                                    //                               : Colors
                                    //                                   .grey),
                                    //                       color: selectedTaileIndex !=
                                    //                                   null &&
                                    //                               taille[selectedTaileIndex!] ==
                                    //                                   e
                                    //                           ? Colors.red
                                    //                           : Colors
                                    //                               .transparent,
                                    //                       borderRadius:
                                    //                           const BorderRadius.all(
                                    //                               Radius.circular(
                                    //                                   5))),
                                    //                   child: Text(
                                    //                     e,
                                    //                     style: TextStyle(
                                    //                         color: selectedTaileIndex !=
                                    //                                     null &&
                                    //                                 taille[selectedTaileIndex!] ==
                                    //                                     e
                                    //                             ? Colors.white
                                    //                             : Colors.grey,
                                    //                         fontSize: 14),
                                    //                   ),
                                    //                 ),
                                    //               );
                                    //             }).toList(),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const Padding(
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: 10),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.start,
                                    //           children: [
                                    //             Text(
                                    //               'Couleurs',
                                    //               style:
                                    //                   TextStyle(fontSize: 16),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       SingleChildScrollView(
                                    //         scrollDirection: Axis.horizontal,
                                    //         child: Row(
                                    //           children: [
                                    //             Wrap(
                                    //               children: Couleurs.map((e) {
                                    //                 int index =
                                    //                     Couleurs.indexOf(e);
                                    //                 return GestureDetector(
                                    //                   onTap: () {
                                    //                     setState(() {
                                    //                       selectedCouleurIndex =
                                    //                           index;
                                    //                     });
                                    //                   },
                                    //                   child: Container(
                                    //                     margin: const EdgeInsets
                                    //                         .only(right: 10),
                                    //                     alignment:
                                    //                         Alignment.center,
                                    //                     padding:
                                    //                         const EdgeInsets
                                    //                             .symmetric(
                                    //                             horizontal: 15,
                                    //                             vertical: 5),
                                    //                     decoration: BoxDecoration(
                                    //                         border: Border.all(
                                    //                             width: 1,
                                    //                             color: selectedCouleurIndex !=
                                    //                                         null &&
                                    //                                     Couleurs[selectedCouleurIndex!] ==
                                    //                                         e
                                    //                                 ? Colors
                                    //                                     .transparent
                                    //                                 : Colors
                                    //                                     .grey),
                                    //                         color: selectedCouleurIndex !=
                                    //                                     null &&
                                    //                                 Couleurs[selectedCouleurIndex!] ==
                                    //                                     e
                                    //                             ? Colors.red
                                    //                             : Colors
                                    //                                 .transparent,
                                    //                         borderRadius:
                                    //                             const BorderRadius.all(
                                    //                                 Radius.circular(
                                    //                                     5))),
                                    //                     child: Text(
                                    //                       e,
                                    //                       style: TextStyle(
                                    //                           color: selectedCouleurIndex !=
                                    //                                       null &&
                                    //                                   Couleurs[
                                    //                                           selectedCouleurIndex!] ==
                                    //                                       e
                                    //                               ? Colors.white
                                    //                               : Colors.grey,
                                    //                           fontSize: 14),
                                    //                     ),
                                    //                   ),
                                    //                 );
                                    //               }).toList(),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
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
                                                          ? ProduitWidget(
                                                              isPageDetails3:
                                                                  false,
                                                              produit: element,
                                                              isCreateCategorie:
                                                                  false,
                                                              isAllList: true,
                                                              isFromcategorie:
                                                                  false,
                                                            )
                                                          : const SizedBox()),
                                                ))
                                            .toList()),
                                  ),
                                ),
                              const SizedBox(
                                height: 120,
                              )
                            ],
                          ))),
                          const SizedBox(
                            height: 0,
                          )
                        ])),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: const RoundedRectangleBorder()),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.black,
                                )),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: const RoundedRectangleBorder()),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          )
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
                  ),
                )
              ],
            )));
  }
}
