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
          padding: const EdgeInsets.all(2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            color: Colors.red,
                          )),
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
                          const Expanded(
                              child: Divider(
                            color: Colors.red,
                          ))
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return BoutiquePage();
                          }));
                        },
                        child: const Text(
                          'Sana\'s market',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        onPressed: () {},
                        child: const Text(
                          'S\'abonner',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    widget.publication!.description!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: widget.produits!
                      .map((e) => ProduitWidget(
                            produit: e,
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
