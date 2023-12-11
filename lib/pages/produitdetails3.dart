import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/producDetails2.dart';

import '../controllers.dart/appController.dart';
import 'home2.dart';

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
                color: Colors.orange,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title:
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                            color: Colors.orange,
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
                            color: Colors.orange,
                          ))
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return home();
                          }));
                        },
                        child: const Text(
                          'Sana\'s market',
                          style: TextStyle(color: Colors.orange, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        onPressed: () {},
                        child: const Text('S\'abonner'),
                      )
                    ],
                  ),
                ),
                Text(
                  widget.publication!.description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: widget.produits!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DetailsPage2(
                                produit: e,
                                isProduiCherche: false,
                              );
                            }));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                width: MediaQuery.of(context).size.width / 2.2,
                                margin: const EdgeInsets.all(2),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: e.images!.first,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  color: Colors.white.withOpacity(0.8),
                                  // height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 2.05,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.nom == '' ? e.categorie! : e.nom!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                          const Text(
                                            '5000 FCFA',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                                backgroundColor: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
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
