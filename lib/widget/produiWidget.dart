import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shopapp/pages/ViewProduit.dart';
import 'package:shopapp/pages/producDetails2.dart';

import '../controllers.dart/appController.dart';
import '../models/productModels.dart';

class ProduitWidget extends StatefulWidget {
  List<Produit>? produits;
  bool? isCreateCategorie;
  double? prixSelected;
  Produit? produit;
  bool? isAllList;
  bool? isFromcategorie;
  bool? isPageDetails3;
  final Function(bool isSelected)? onSelect;
  final Function(String, String, String, double prix, String id)?
      onUpdateProductDetails;
  ProduitWidget(
      {super.key,
      this.produit,
      this.prixSelected,
      this.produits,
      this.isCreateCategorie,
      this.onUpdateProductDetails,
      this.isPageDetails3,
      this.isAllList,
      this.isFromcategorie,
      this.onSelect});

  @override
  State<ProduitWidget> createState() => _ProduitWidgetState();
}

class _ProduitWidgetState extends State<ProduitWidget> {
  bool isSelected = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String?> favoris =
      authController.usermodel.value.cartList!.map((e) => e.productId).toList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isCreateCategorie!
        ? _nameController.text = widget.produit!.nom!
        : null;
    widget.isCreateCategorie!
        ? _descriptionController.text = widget.produit!.description!
        : null;
    widget.isCreateCategorie!
        ? _prixController.text = widget.produit!.prix!.toString()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isCreateCategorie == false
            ? Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
                return DetailsPage2(
                  isFromCategorie: false,
                  produit: widget.produit,
                );
                // return ViewProduit(
                //   pageController: PageController(
                //       initialPage: widget.produits!.indexOf(widget.produit!)),
                //   quantity: 1,
                //   prouit: widget.produit!,
                //   produits: widget.produits,
                // );
              }))
            : Get.defaultDialog(
                title: '',
                content: SizedBox(
                  // height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.withOpacity(0.2),
                                      filled: true,
                                      border: InputBorder.none,
                                      // border: const OutlineInputBorder(
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.circular(10))),
                                      hintText: 'Nom',
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _prixController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.withOpacity(0.2),
                                      filled: true,
                                      border: InputBorder.none,
                                      // border: const OutlineInputBorder(
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.circular(10))),
                                      hintText: 'Prix',
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _descriptionController,
                              style: const TextStyle(color: Colors.black),
                              maxLines: 3,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.withOpacity(0.2),
                                filled: true,
                                border: InputBorder.none,
                                // border: const OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10))),
                                hintText: 'Description',
                                hintStyle: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  // Récupérez les nouvelles informations saisies dans la boîte de dialogue
                                  String newName = _nameController.text;
                                  String newDescription =
                                      _descriptionController.text;
                                  double newPrix =
                                      double.parse(_prixController.text);

                                  // Appelez la fonction de rappel pour mettre à jour les détails du produit sur la page parente
                                  widget.onUpdateProductDetails!(
                                      newName,
                                      newDescription,
                                      widget.produit!.images!.first,
                                      newPrix,
                                      widget.produit!.id!);
                                  Navigator.pop(
                                      context); // Fermez la boîte de dialogue
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Valider',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            // DropdownButton pour la catégorie
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
      },
      child: Card(
        color: widget.isCreateCategorie == true
            ? Colors.grey.withOpacity(0.3)
            : Colors.white,
        elevation: widget.isPageDetails3! ? 2 : 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        margin: const EdgeInsets.all(3),
        child: SizedBox(
          // decoration: const BoxDecoration(
          //     // color: Colors.grey.withOpacity(0.3),
          //     borderRadius: const BorderRadius.all(Radius.circular(0))),
          height: MediaQuery.of(context).size.height / 3.8,
          width: widget.isAllList!
              ? MediaQuery.of(context).size.width / 2.8
              : MediaQuery.of(context).size.width / 2.8,
          // margin: const EdgeInsets.all(3),
          child: Stack(
            children: [
              Column(
                children: [
                  widget.isCreateCategorie == false
                      ? Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0)),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: widget.produit!.images!.first,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0)),
                                  child: Image.file(
                                    File(widget.produit!.images!.first),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )),
                              if (widget.isCreateCategorie! &&
                                  widget.produit!.description != '')
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0))),
                                  child: Text(
                                    widget.produit!.description!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),

                    // height: 50,
                    // width: MediaQuery.of(context).size.width / 2.1,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !widget.isCreateCategorie!
                                ? Text(
                                    widget.produit!.nom == ''
                                        ? widget.produit!.categorie!
                                        : widget.produit!.nom!,
                                    style: const TextStyle(fontSize: 16))
                                : Text(
                                    widget.produit!.nom == ''
                                        ? 'Nom'
                                        : widget.produit!.nom!,
                                    style: const TextStyle(fontSize: 16)),
                            widget.produit!.prix != 0.0
                                ? Text(
                                    widget.produit!.prix!.toInt().toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  )
                                : const Text(
                                    'prix',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                            if (widget.isCreateCategorie == false &&
                                widget.isPageDetails3 == false)
                              const Text(
                                'Sana\'s market',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                          ],
                        ),
                        const Spacer(),
                        if (widget.isPageDetails3 != null &&
                            widget.isPageDetails3 == true)
                          Row(
                            children: [
                              // OutlinedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     shape: const RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(15))),
                              //     elevation: 0,
                              //   ),
                              //   onPressed: () {},
                              //   child: const Icon(Icons.share),
                              // ),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        // side: const BorderSide(color: Colors.black),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0))),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        cartController.addProductToCart(
                                          [widget.produit!],
                                          context,
                                          1,
                                        );
                                      },
                                      child: const Text(
                                        'Payer',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        // side: const BorderSide(color: Colors.black),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0))),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        cartController.addProductToCart(
                                          [widget.produit!],
                                          context,
                                          1,
                                        );
                                      },
                                      child: const Text(
                                        'Ajouter au panier',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      )),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
              // if (isSelected)
              if (widget.isCreateCategorie! && widget.prixSelected != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Checkbox(
                    value: widget.prixSelected == widget.produit!.prix
                        ? true
                        : false,
                    onChanged: (value) {
                      widget.prixSelected != null
                          ? setState(() {
                              isSelected = value!;
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.white,
                                showCloseIcon: true,
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                      'Choisissez d\'abords un prix ',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                      widget.onSelect!(isSelected);
                    },
                  ),
                ),
              // if (widget.isCreateCategorie == false)
              //   Positioned(
              //       top: 1,
              //       right: -1,
              //       child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor: Colors.white.withOpacity(0.8),
              //               shape: const CircleBorder()),
              //           onPressed: () {
              //             favoris
              //                     .where((element) =>
              //                         element == widget.produit!.id)
              //                     .isEmpty
              //                 ? favoris.add(widget.produit!.id)
              //                 : favoris.remove(widget.produit!.id);
              //             setState(() {});
              //           },
              //           child: favoris
              //                   .where(
              //                       (element) => element == widget.produit!.id)
              //                   .isEmpty
              //               ? const Icon(
              //                   Icons.favorite_border,
              //                   color: Colors.black,
              //                 )
              //               : const Icon(
              //                   Icons.favorite,
              //                   color: Colors.black,
              //                 )))
            ],
          ),
        ),
      ),
    );
  }
}
