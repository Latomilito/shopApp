import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/pages/BoutiquePage.dart';
import 'package:shopapp/pages/ViewProduit.dart';
import 'package:shopapp/pages/producDetails2.dart';
import 'package:shopapp/pages/produitdetails3.dart';
import 'package:shopapp/utility/Utility.dart';

import '../models/productModels.dart';
import '../pages/CategorieVendeur.dart';
import '../pages/ComSheet.dart';

class buildCategoryGrid extends StatefulWidget {
  final List<Produit> produits;
  final String title;
  BuildContext? context1;
  PublicationStandard? publication;
  final int nombreArticles;
  final Widget? pageToOpen; // Nouveau paramètre

  buildCategoryGrid({
    this.context1,
    this.publication,
    required this.produits,
    required this.title,
    this.nombreArticles = 12,
    this.pageToOpen, // Ajout du nouveau paramètre
  });

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<buildCategoryGrid>
    with SingleTickerProviderStateMixin {
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
      // onLongPress: () {
      //   FirebaseFirestore.instance
      //       .collection('publications')
      //       .doc(widget.publication!.id)
      //       .delete();
      // },
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
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        color: Colors.grey.withOpacity(0.05),
        // color: Colors.orangeAccent.withOpacity(0.2),
        // elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
              // bottom: 12,
              right: widget.title != '' ? 0 : 12,
              left: widget.title != '' ? 0 : 12),
          child: Column(
            children: [
              const Divider(),
              widget.publication == null
                  ? buildCategorySection(
                      nombrearticle: widget.produits.length,
                      title: widget.title,
                    )
                  : buildCategorySection(
                      title: widget.title, publication: widget.publication!),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.produits.length < 12
                      ? widget.nombreArticles % 2 == 0
                          ? (widget.nombreArticles == 2
                              ? widget.nombreArticles
                              : widget.nombreArticles ~/ 2)
                          : (widget.nombreArticles == 1
                              ? widget.nombreArticles
                              : widget.nombreArticles == 3
                                  ? widget.nombreArticles
                                  : ((widget.nombreArticles + 1) ~/ 2))
                      : 4,
                ),
                itemCount: produitsMelange!.length >= widget.nombreArticles
                    ? produitsMelange!.sublist(0, widget.nombreArticles).length
                    : produitsMelange!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.publication != null
                          ? index == 11 &&
                                  (widget.produits.length -
                                          widget.nombreArticles) !=
                                      0
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                  return DetailsPage3(
                                    produits: widget.produits,
                                    publication: widget.publication,
                                  );
                                }))
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                  // return ViewProduit(
                                  //   pageController: PageController(
                                  //       initialPage: widget.produits
                                  //           .indexOf(widget.produits[index])),
                                  //   quantity: 1,
                                  //   prouit: widget.produits[index],
                                  //   produits: widget.produits,
                                  // );
                                  return DetailsPage2(
                                    produit: widget.produits[index],
                                    isFromCategorie: false,
                                  );
                                }))
                          : Navigator.of(context).push(
                              index != 11
                                  ? MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        // return DetailsPage2(
                                        //   produit: widget.produits[index],
                                        //   isFromCategorie: false,
                                        // );
                                        return ViewProduit(
                                          pageController: PageController(
                                              initialPage: widget.produits
                                                  .indexOf(
                                                      widget.produits[index])),
                                          quantity: 1,
                                          prouit: widget.produits[index],
                                          produits: widget.produits,
                                        );
                                      },
                                    )
                                  : MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return CategorieVendeur(
                                          categorieSelected:
                                              produitsMelange!.first.categorie,
                                        );
                                      },
                                    ),
                            );
                    },
                    child: Card(
                      margin: widget.publication != null &&
                              widget.publication!.productIds!.length == 1
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 0,
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
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
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              imageUrl: produitsMelange!.length >=
                                      widget.nombreArticles
                                  ? produitsMelange!
                                      .sublist(0, widget.nombreArticles)[index]
                                      .images!
                                      .first
                                  : produitsMelange![index].images!.first,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: index == 11 &&
                                      (widget.produits.length -
                                              widget.nombreArticles) !=
                                          0
                                  ? Colors.black.withOpacity(0.6)
                                  : Colors.transparent,
                              child: Center(
                                child: index == 11 &&
                                        (widget.produits.length -
                                                widget.nombreArticles) !=
                                            0
                                    ? Text(
                                        widget.publication == null
                                            ? '+${widget.produits.length - widget.nombreArticles + 1}'
                                            : '+${widget.publication!.productIds!.length - 11}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    : const SizedBox(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
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
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                          // Use the EvaIcons class for the IconData
                          icon: const Icon(EvaIcons.messageCircleOutline),
                          onPressed: () {
                            showProductBottomSheet(
                              context,
                              this,
                            );
                            print("Eva Icon heart Pressed");
                          }),
                      const Positioned(
                        bottom: 10,
                        right: 0,
                        child: Text(
                          '+40',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
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
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'aimés par Tif et 12 autres..',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection(
      {String? title, PublicationStandard? publication, int? nombrearticle}) {
    return Container(
      // margin: const EdgeInsets.only(top: 5),
      // padding: const EdgeInsets.only(left: 11),
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
                      return BoutiquePage();
                    }));
                  },
                  child: const Text(
                    'Sana\'s market',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
                const Spacer(),
                if (publication != null)
                  Text(
                    '${Utilities.getDayName(publication.date!.weekday)} le ${publication.date!.day} ${Utilities.getMonthName(publication.date!.month)} à ${publication.date!.hour}h ${publication.date!.minute}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),

          if (title != '')
            Card(
              elevation: 0,
              child: Row(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          // ignore: unnecessary_null_comparison
          if (publication != null && publication.description != '')
            Text(
              publication.description!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),

          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
