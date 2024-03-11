import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/appController.dart';

class CatalogAdmin extends StatefulWidget {
  const CatalogAdmin({super.key});

  @override
  State<CatalogAdmin> createState() => _CatalogAdminState();
}

class _CatalogAdminState extends State<CatalogAdmin> {
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Ajouter une Collection',
          style: GoogleFonts.acme(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: categoriesSet.toList().length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                String categorie = categoriesSet.toList()[index];
                return Card(
                  child: Text(categorie),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
