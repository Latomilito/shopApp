import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/pages/producDetails2.dart';

import '../controllers.dart/appController.dart';
import '../models/productModels.dart';

class ProduitWidget extends StatefulWidget {
  Produit? produit;
  ProduitWidget({super.key, this.produit});

  @override
  State<ProduitWidget> createState() => _ProduitWidgetState();
}

class _ProduitWidgetState extends State<ProduitWidget> {
  List<String?> favoris =
      authController.usermodel.value.cartList!.map((e) => e.productId).toList();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return DetailsPage2(
            produit: widget.produit,
            isFromCategorie: false,
          );
        }));
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width / 2.1,
        margin: const EdgeInsets.all(2),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: widget.produit!.images!.first,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),

                  // height: 50,
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.produit!.nom == ''
                            ? widget.produit!.categorie!
                            : widget.produit!.nom!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.produit!.prix!.toInt().toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        'Sana\'s market',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 1,
                right: -1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        shape: const CircleBorder()),
                    onPressed: () {
                      favoris
                              .where((element) => element == widget.produit!.id)
                              .isEmpty
                          ? favoris.add(widget.produit!.id)
                          : favoris.remove(widget.produit!.id);
                      setState(() {});
                    },
                    child: favoris
                            .where((element) => element == widget.produit!.id)
                            .isEmpty
                        ? const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )))
          ],
        ),
      ),
    );
  }
}
