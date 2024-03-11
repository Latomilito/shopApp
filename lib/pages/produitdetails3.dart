import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/widget/produiWidget.dart';
import '../controllers.dart/appController.dart';
import 'BoutiquePage.dart';

// ignore: must_be_immutable
class DetailsPage3 extends StatefulWidget {
  List<Produit>? produits;
  PublicationStandard? publication;
  DetailsPage3({super.key, this.publication, this.produits});
  @override
  State<DetailsPage3> createState() => _DetailsPage3State();
}

class _DetailsPage3State extends State<DetailsPage3> {
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
                color: Colors.red,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title:
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Column(
                          //   children: [
                          //     Text(
                          //       '30 abonnements',
                          //       style:
                          //           TextStyle(color: Colors.grey, fontSize: 18),
                          //     ),
                          //     Divider(
                          //       color: Colors.red,
                          //     ),
                          //   ],
                          // )),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(120)),
                            child: CachedNetworkImage(
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                                imageUrl: repositoryController
                                    .allproduits.first.images!.first),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return BoutiquePage();
                                        }));
                                      },
                                      child: const Text(
                                        'Sana\'s market',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 15),
                                      ),
                                    ),
                                    const Text(
                                      '50 abonnées',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '|',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.red,
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    widget.publication!.description!,
                    // textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3.5, crossAxisCount: 1),
                  itemCount: widget.produits!.length,
                  itemBuilder: (context, index) {
                    Produit produit = widget.produits![index];
                    return Hero(
                      tag: 'bon',
                      // tag: widget.produits![index].id!,
                      child: ProduitWidget(
                        produits: widget.produits,
                        isPageDetails3: true,
                        produit: produit,
                        isAllList: true,
                        isCreateCategorie: false,
                        isFromcategorie: false,
                      ),
                    );
                  },
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                        'Voir d\'autres ${widget.produits!.first.categorie}'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
