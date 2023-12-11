import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/pages/ProducDetails.dart';

import '../controllers.dart/appController.dart';
import '../models/StandarPublication.dart';
import '../models/productModels.dart';
import '../utility/Utility.dart';
import 'ComSheet.dart';
import 'home2.dart';

class DetailsPage2 extends StatefulWidget {
  Produit? produit;
  bool? isProduiCherche;
  DetailsPage2({super.key, this.produit, this.isProduiCherche});

  @override
  State<DetailsPage2> createState() => _HistorieState();
}

class _HistorieState extends State<DetailsPage2> {
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.orange,
                  ),
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(360)),
                    child: CachedNetworkImage(
                        height: 30,
                        width: 30,
                        imageUrl: repositoryController
                            .allproduits.first.images!.first),
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
                ],
              ),
            ),
            bottomNavigationBar: ProductCommentsBottomSheet(
              produit: widget.produit!,
            ),
            // bottomSheet:
            body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                          alignment: Alignment.topCenter,
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              widget.produit!.images!.first),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: double.infinity,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.produit!.nom == ''
                                                          ? widget.produit!
                                                              .categorie!
                                                          : widget
                                                              .produit!.nom!,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                    const Text(
                                                      '5000 FCFA',
                                                      style: TextStyle(
                                                          backgroundColor:
                                                              Colors.white,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 2,
                                                    left: 5,
                                                    right: 5,
                                                    top: 2,
                                                  ),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.orange,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(vertical: 7),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             widget.produit!.nom == ''
                                //                 ? widget.produit!.categorie!
                                //                 : widget.produit!.nom!,
                                //             style: const TextStyle(
                                //                 fontSize: 18,
                                //                 color: Colors.black),
                                //           ),
                                //           const Text(
                                //             '5000 FCFA',
                                //             style: TextStyle(
                                //                 color: Colors.orange,
                                //                 fontSize: 17),
                                //           ),
                                //         ],
                                //       ),
                                //       const Spacer(),
                                //       const Padding(
                                //         padding: EdgeInsets.only(
                                //           bottom: 5,
                                //           left: 5,
                                //           right: 5,
                                //           top: 5,
                                //         ),
                                //         child: Icon(
                                //           Icons.favorite_border,
                                //           color: Colors.orange,
                                //           size: 30,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Description',
                                //       style: TextStyle(fontSize: 17),
                                //     ),
                                //     Divider(
                                //       color: Colors.orange,
                                //     )
                                //   ],
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    widget.produit!.description ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.grey),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Produits similaires',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        const Spacer(),
                                        if (widget.isProduiCherche!)
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return DetailsPage(
                                                  categorieCherche:
                                                      widget.produit!.categorie,
                                                  quantity: 1,
                                                );
                                              }));
                                            },
                                            child: const Text('voir plus'),
                                          )
                                      ],
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.orange,
                                    )
                                  ],
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
                                  children: repositoryController.allproduits
                                      .where((elemet) =>
                                          elemet.categorie ==
                                              widget.produit!.categorie &&
                                          elemet.id != widget.produit!.id)
                                      .map((element) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return DetailsPage2(
                                                    isProduiCherche: false,
                                                    produit: element,
                                                  );
                                                }));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    '6000 FCFA',
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CachedNetworkImage(
                                                    height: 90,
                                                    width: 90,
                                                    imageUrl:
                                                        element.images!.first,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'd\'autres catégories',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    if (widget.isProduiCherche!)
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return DetailsPage(
                                              categorieCherche:
                                                  widget.produit!.categorie,
                                              quantity: 1,
                                            );
                                          }));
                                        },
                                        child: const Text('voir plus'),
                                      )
                                  ],
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.orange,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            // height: 100,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: categoriesSet
                                    .toList()
                                    .where((elemet) =>
                                        elemet != widget.produit!.categorie)
                                    .map((element) {
                                  Produit produit = repositoryController
                                      .allproduits
                                      .firstWhere((element1) =>
                                          element1.categorie == element);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailsPage(
                                            categorieCherche: element,
                                          );
                                        }));
                                      },
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height: 90,
                                            width: 90,
                                            imageUrl: produit.images!.first,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 90,
                                            width: 90,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            child: Text(
                                              produit.categorie!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
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
                      )))
                    ]))));
  }
}
