import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';

class Home4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          backgroundColor: Colors
              .orange, // Couleur personnalisée pour la barre d'applications
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: CachedNetworkImage(
                              imageUrl: repositoryController
                                  .allproduits[16].images!.first),
                        ),
                      ),
                      Container(
                        // color: Colors.orange,
                        height: 200,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: repositoryController
                                    .allproduits[10].images!.first),
                            const SizedBox(
                              width: 10,
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 3,
                            //   child: const Column(
                            //     children: [
                            //       Text(
                            //         'Ajoutez une paire de chaussures en cuir à votre collection, et faites l\'expérience de l\'alliance parfaite entre élégance, confort et durabilité',
                            //         textAlign: TextAlign.justify,
                            //         style: TextStyle(fontSize: 15),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
