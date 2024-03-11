import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/CategorieVendeur.dart';
import 'package:uuid/data.dart';

class CommentBottomSheet extends StatefulWidget {
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: Container(
                child: GestureDetector(
                  onTap: () {
                    _focusNode.unfocus();
                  },
                ),
              )),
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      focusNode: _focusNode,
                      // validator: ValidationBuilder().required().build(),
                      controller: textController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Commentez ici...',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: EmojiFeedback(
                    elementSize: 40,
                  )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: const CircleBorder()),
                    onPressed: () {},
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

void showProductBottomSheet(BuildContext context, TickerProvider vsync) {
  showBottomSheet(
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,

    transitionAnimationController: AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    ),
    builder: (context) {
      return BottomSheet(
        showDragHandle: true,
        enableDrag: true,
        onDragStart: (details) {
          details = DragStartDetails();
        },
        onClosing: () {},
        builder: (context) {
          return CommentBottomSheet();
        },
      );
    },
    // isScrollControlled: true,
  );
}

Future<List<String>?> afficherListeCategorie(BuildContext context) async {
  return await showModalBottomSheet<List<String>>(
    isDismissible: true,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: CategorieBottomsheet(),
      );
    },
    isScrollControlled: true,
  );
}

class CategorieBottomsheet extends StatefulWidget {
  const CategorieBottomsheet({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EtatCategorieBottomsheet createState() => _EtatCategorieBottomsheet();
}

class _EtatCategorieBottomsheet extends State<CategorieBottomsheet> {
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();
  late TextEditingController _controller; // Déclaration du contrôleur de texte
  List<String> categoriesselectionnes = [];
  List<String> categoriesAffiches = [];
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    categoriesAffiches.addAll(categoriesSet
        .toList()); // Initialisation des produits affichés avec tous les produits
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sélectionner des produits'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context, categoriesselectionnes);
              },
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search_outlined,
                      size: 30,
                    ),
                    hintStyle: GoogleFonts.acme(fontSize: 17),
                    hintText: 'Chercher un produit...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      categoriesAffiches
                          .clear(); // Effacer la liste des produits affichés actuellement

                      // Filtrer les produits en fonction de la recherche
                      for (String categorie in categoriesSet.toList()) {
                        if (categorie
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          categoriesAffiches.add(categorie);
                        }
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categoriesAffiches
                      .length, // Utilisation de la liste des produits affichés
                  itemBuilder: (context, index) {
                    String categorie = categoriesAffiches[
                        index]; // Utilisation de la liste des produits affichés
                    bool estSelectionne =
                        categoriesselectionnes.contains(categorie);
                    return ListTile(
                      title: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (categorie != '') Text(categorie),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Checkbox(
                            value: estSelectionne,
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value) {
                                  categoriesselectionnes.add(categorie);
                                } else {
                                  categoriesselectionnes.remove(categorie);
                                }
                              });
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Produit>?> afficherListeProduits(BuildContext context) async {
  return await showModalBottomSheet<List<Produit>>(
    useSafeArea: true,
    isDismissible: true,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: FeuilleDeBasProduits(),
      );
    },
    isScrollControlled: true,
  );
}

class FeuilleDeBasProduits extends StatefulWidget {
  const FeuilleDeBasProduits({Key? key}) : super(key: key);

  @override
  _EtatFeuilleDeBasProduits createState() => _EtatFeuilleDeBasProduits();
}

class _EtatFeuilleDeBasProduits extends State<FeuilleDeBasProduits> {
  int curentIndex = 0;
  String? categoriSelected;
  PageController pageController = PageController(initialPage: 0);
  Set<Produit> productNamesSet =
      repositoryController.allproduits.map((element) => element).toSet();
  late TextEditingController _controller;
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet(); // Déclaration du contrôleur de texte
  List<Produit> produitsSelectionnes = [];
  List<Produit> produitsAffiches =
      []; // Déclaration de la liste des produits affichés
  String filterQuery = '';
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    produitsAffiches.addAll(repositoryController
        .allproduits); // Initialisation des produits affichés avec tous les produits
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Sélectionner des produits'),
      //     actions: [
      //       IconButton(
      //         onPressed: () {
      //           Navigator.pop(context, produitsSelectionnes);
      //         },
      //         icon: const Icon(Icons.check),
      //       ),
      //     ],
      //   ),
      //   body:
      // ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // height: MediaQuery.of(context).size.height - 100,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    curentIndex == 1
                        ? pageController.jumpToPage(0)
                        : Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, produitsSelectionnes);
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search_outlined,
                    size: 30,
                  ),
                  hintStyle: GoogleFonts.acme(fontSize: 17),
                  hintText: curentIndex == 0
                      ? 'Chercher une catégorie...'
                      : 'Chercher un produit...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    produitsAffiches
                        .clear(); // Effacer la liste des produits affichés actuellement
                    filterQuery = value;
                    produitsAffiches = repositoryController.allproduits
                        .where((element) =>
                            element.categorie!.toLowerCase() ==
                            categoriSelected!.toLowerCase())
                        .where((productName) => (productName.nom!
                                .toLowerCase()
                                .contains(filterQuery.toLowerCase()) ||
                            productName.categorie!
                                .toLowerCase()
                                .contains(filterQuery.toLowerCase())))
                        .toList();
                    // Filtrer les produits en fonction de la recherche
                    // for (Produit produit
                    //     in repositoryController.allproduits) {
                    //   if (produit.nom!
                    //       .toLowerCase()
                    //       .contains(value.toLowerCase())) {
                    //     produitsAffiches.add(produit);
                    //   }
                    // }
                  });
                },
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    curentIndex = value;
                    filterQuery = '';
                  });
                },
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, mainAxisExtent: 70),
                    itemCount: categoriesSet
                        .where((category) => category
                            .toLowerCase()
                            .contains(filterQuery.toLowerCase()))
                        .length,
                    itemBuilder: (context, index) {
                      List<String> cattegories = categoriesSet
                          .where((category) => category
                              .toLowerCase()
                              .contains(filterQuery.toLowerCase()))
                          .toList();
                      Produit produit = repositoryController.allproduits
                          .firstWhere((element) =>
                              element.categorie == cattegories[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            categoriSelected = produit.categorie!;
                            produitsAffiches = repositoryController.allproduits
                                .where((element) => element.categorie!
                                    .contains(produit.categorie!))
                                .toList();
                          });
                          filterQuery = '';
                          pageController.jumpToPage(1);
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (BuildContext context) {
                          //   return CategorieVendeur(
                          //       categorieSelected: produit.categorie);
                          // }));
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
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: produitsAffiches
                          .length, // Utilisation de la liste des produits affichés
                      itemBuilder: (context, index) {
                        Produit produit = produitsAffiches[
                            index]; // Utilisation de la liste des produits affichés
                        bool estSelectionne =
                            produitsSelectionnes.contains(produit);
                        return ListTile(
                          title: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: produit.images!.first,
                                    width: double.infinity,
                                    height: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(produit.nom == ''
                                        ? produit.categorie!
                                        : produit.nom!),
                                    Text(
                                      produit.prix.toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: estSelectionne,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null && value) {
                                      produitsSelectionnes.add(produit);
                                    } else {
                                      produitsSelectionnes.remove(produit);
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Wrap(
            //       // mainAxisAlignment: MainAxisAlignment.start,
            //       // spacing: 8.0,
            //       // runSpacing: 8.0,
            //       children: categoriesSet
            //           .where((category) => category
            //               .toLowerCase()
            //               .contains(filterQuery.toLowerCase()))
            //           .map((category) {
            //         int index = categoriesSet
            //             .where((category) => category
            //                 .toLowerCase()
            //                 .contains(filterQuery.toLowerCase()))
            //             .toList()
            //             .indexOf(category);
            //         Produit produit = repositoryController.allproduits
            //             .firstWhere((element) => element.categorie == category);
            //         return GestureDetector(
            //           onTap: () {
            //             Navigator.of(context).push(
            //                 MaterialPageRoute(builder: (BuildContext context) {
            //               return CategorieVendeur(
            //                   categorieSelected: produit.categorie);
            //             }));
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.all(2),
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 2, horizontal: 2),
            //             child: Stack(
            //               children: [
            //                 ClipRRect(
            //                   borderRadius:
            //                       const BorderRadius.all(Radius.circular(10)),
            //                   child: CachedNetworkImage(
            //                     height: 70,
            //                     width: 85,
            //                     imageUrl: produit.images!.first,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //                 Container(
            //                   alignment: Alignment.center,
            //                   height: 70,
            //                   width: 85,
            //                   decoration: BoxDecoration(
            //                     color: Colors.black.withOpacity(0.6),
            //                     borderRadius:
            //                         const BorderRadius.all(Radius.circular(10)),
            //                   ),
            //                   child: Text(
            //                     produit.categorie!,
            //                     textAlign: TextAlign.center,
            //                     style: const TextStyle(
            //                         color: Colors.white, fontSize: 16),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: produitsAffiches
            //         .length, // Utilisation de la liste des produits affichés
            //     itemBuilder: (context, index) {
            //       Produit produit = produitsAffiches[
            //           index]; // Utilisation de la liste des produits affichés
            //       bool estSelectionne = produitsSelectionnes.contains(produit);
            //       return ListTile(
            //         title: Row(
            //           children: [
            //             Container(
            //               height: 70,
            //               width: 70,
            //               decoration: const BoxDecoration(
            //                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //               ),
            //               child: ClipRRect(
            //                 borderRadius:
            //                     const BorderRadius.all(Radius.circular(10)),
            //                 child: CachedNetworkImage(
            //                   imageUrl: produit.images!.first,
            //                   width: double.infinity,
            //                   height: double.maxFinite,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.symmetric(
            //                   horizontal: 10, vertical: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(produit.nom == ''
            //                       ? produit.categorie!
            //                       : produit.nom!),
            //                   Text(
            //                     produit.prix.toString(),
            //                     style: const TextStyle(
            //                       color: Colors.red,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             const Spacer(),
            //             Checkbox(
            //               value: estSelectionne,
            //               onChanged: (value) {
            //                 setState(() {
            //                   if (value != null && value) {
            //                     produitsSelectionnes.add(produit);
            //                   } else {
            //                     produitsSelectionnes.remove(produit);
            //                   }
            //                 });
            //               },
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showProduitModification(BuildContext context,
    {Produit? produit,
    final Function(String, String, String, double prix)?
        onUpdateProductDetails}) {
  showBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return BottomSheet(
        showDragHandle: true,
        enableDrag: true,

        // animationController: AnimationController(vsync: ),
        onClosing: () {},
        builder: (context) {
          return SizedBox(
              // height: MediaQuery.of(context).size.height - 200,
              child: AjouterProduitBottomsheet(
            onUpdateProductDetails: onUpdateProductDetails,
            produit: produit,
          ));
        },
      );
    },
  );
}

class AjouterProduitBottomsheet extends StatefulWidget {
  Produit? produit;
  final Function(String, String, String, double prix)? onUpdateProductDetails;
  AjouterProduitBottomsheet({
    super.key,
    this.produit,
    this.onUpdateProductDetails,
  });

  @override
  State<AjouterProduitBottomsheet> createState() =>
      _AjouterProduitBottomsheetState();
}

class _AjouterProduitBottomsheetState extends State<AjouterProduitBottomsheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          // margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height / 5,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(width: 0)),
          child: Image.file(
            File(widget.produit!.images!.first),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextFormField(
                  // controller: _nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Nom',
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  // controller: _prixController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Prix',
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: TextField(
            // controller: _descriptionController,
            style: const TextStyle(color: Colors.black),
            maxLines: 3,
            decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              border: InputBorder.none,
              hintText: 'Description',
              hintStyle: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Récupérez les nouvelles informations saisies dans la boîte de dialogue
              String newName = _nameController.text;
              String newDescription = _descriptionController.text;
              double newPrix = double.parse(_prixController.text);

              // Appelez la fonction de rappel pour mettre à jour les détails du produit sur la page parente
              widget.onUpdateProductDetails!(newName, newDescription,
                  widget.produit!.images!.first, newPrix);
              Navigator.pop(context); // Fermez la boîte de dialogue
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Valider',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
