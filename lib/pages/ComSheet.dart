import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:get/get.dart';
import 'package:shopapp/models/productModels.dart';

import '../controllers.dart/appController.dart';
import '../utility/Utility.dart';
import 'ProducDetails.dart';
import 'home2.dart';

class ProductCommentsBottomSheet extends StatefulWidget {
  Produit? produit;

  ProductCommentsBottomSheet({this.produit});

  @override
  _ProductCommentsBottomSheetState createState() =>
      _ProductCommentsBottomSheetState();
}

class _ProductCommentsBottomSheetState
    extends State<ProductCommentsBottomSheet> {
  int quantity = 1;
  List<String> comments = [
    "Excellent produit !",
    "J'adore la qualité.",
    "Livraison rapide.",
  ];

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: Colors.orange),
          onPressed: () {
            // Navigator.of(context).pop();
            cartController
                .addProductToCart([widget.produit!], context, quantity);
          },
          child: const Text(
            'Ajouter au panier',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}

void showProductCommentsBottomSheet(BuildContext context, String productName) {
  showModalBottomSheet(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        // child: ProductCommentsBottomSheet(produit: produi,),
      );
    },
    isScrollControlled:
        true, // Permet le défilement si la hauteur dépasse l'écran
  );
}

void showProductStoriBottomSheet(
    BuildContext context, List<Produit> produit, int? index) {
  showModalBottomSheet(
    // backgroundColor: Colors.black.withOpacity(0.9),
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) {
      return Container(
          // height: MediaQuery.of(context).size.height / 3,
          child: ProductCommentsBottomSheet(
        produit: produit[index!],
      ));
    },

    // isScrollControlled:
    //     true, // Permet le défilement si la hauteur dépasse l'écran
  );
}
