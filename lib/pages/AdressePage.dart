import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdressePage extends StatefulWidget {
  const AdressePage({super.key});

  @override
  State<AdressePage> createState() => _AdressePageState();
}

class _AdressePageState extends State<AdressePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Mes adresse',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showCustomDialog(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  color: Colors.black.withOpacity(0.05),
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Chez moi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            // const Spacer(),
                          ],
                        ),
                        const Text('Pharmacie Dan gao'),
                        const Text('Niamey'),
                        const Text('92085861'),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text('modifier'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('supprimer'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 10,
                    child: Row(
                      children: [
                        const Text(
                          ' Defaut ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exemple de Dialog'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {
                launchGoogleMaps();
                // Action du bouton dans le Dialog
                print('Bouton cliqué dans le Dialog');
              },
              child: const SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Indique l\'adresse',
                      style: TextStyle(fontSize: 17),
                    ),
                    Icon(Icons.location_on_outlined)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            RoundedTextField(),
            const SizedBox(height: 16),
            RoundedTextField(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le Dialog
            },
            child: const Text('annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le Dialog
            },
            child: const Text('Ajouter'),
          ),
        ],
      );
    },
  );
}

class RoundedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Entrez votre texte',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

void launchGoogleMaps() async {
  String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=Place+de+la+Concorde,Paris";
  String customUrl = "myapp://mapsdata?address=Place+de+la+Concorde%2C+Paris";

  if (await canLaunch(googleMapsUrl)) {
    // Sur une plateforme mobile
    if (Platform.isIOS || Platform.isAndroid) {
      await launch(googleMapsUrl);
    }
    // Sur le web
    else if (kIsWeb) {
      launch(customUrl);
    }
  } else {
    throw 'Impossible d\'ouvrir Google Maps';
  }
}

Future<void> handleMapData(String url) async {
  // Parsez l'URL pour extraire les données nécessaires (par exemple, l'adresse)
  Uri uri = Uri.parse(url);
  String address = uri.queryParameters['address'] ?? '';
  print('Adresse partagée depuis Google Maps : $address');
}
