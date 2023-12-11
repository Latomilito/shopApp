import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers.dart/appController.dart';
import '../models/productModels.dart';
import 'ChampNomProduit.dart';
import 'Champdescription.dart';
import 'Champprix.dart';
import 'SelectCategorie.dart';

class ImageInputDialog extends StatefulWidget {
  final String? imagePath;
  final Produit? produit;
  final String? categorie;
  void Function()? onPressedValider;

  ImageInputDialog({
    Key? key,
    this.imagePath,
    this.produit,
    this.categorie,
    required this.onPressedValider,
  }) : super(key: key);

  @override
  _ImageInputDialogState createState() => _ImageInputDialogState();
}

class _ImageInputDialogState extends State<ImageInputDialog> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController categorieController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool estPopulaire = false;
  bool estNouveau = false;
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();
  @override
  void initState() {
    super.initState();
    if (widget.categorie != null) {
      categorieController.text = widget.categorie!;
    }
    if (widget.produit != null) {
      nomController.text = widget.produit!.nom!;
      categorieController.text = widget.produit!.categorie!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remplissez les champs'),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              widget.produit == null
                  ? Image.file(
                      File(widget.imagePath!),
                      fit: BoxFit.cover,
                      height: 100,
                    )
                  : Image.file(
                      File(widget.produit!.images!.first),
                      fit: BoxFit.cover,
                      height: 100,
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ChampNomProduit(
                      controller: nomController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Le nom du produit ne peut pas être vide';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ChampPrixProduit(
                      isMEme: false,
                      controller: prixController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Le prix du produit ne peut pas être vide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ChampDescriptionProduit(
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'La description du produit ne peut pas être vide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              SelecteurCategorieProduit(
                categorieselected: widget.categorie,
                categories: categoriesSet.toList(),
                onSelect: (selectedCategory) {
                  setState(() {
                    categorieController.text = selectedCategory;
                  });
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Produit Populaire'),
                value: estPopulaire,
                onChanged: (newValue) {
                  setState(() {
                    estPopulaire = newValue ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Nouveau Produit'),
                value: estNouveau,
                onChanged: (newValue) {
                  setState(() {
                    estNouveau = newValue ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // String id = const Uuid().v4();
            // widget.produit != null
            //     ? produitSelectionner.removeWhere((element) =>
            //         element.images!.first == widget.produit!.images!.first)
            //     : null;
            // produitSelectionner.add(Produit(
            //   id: id,
            //   nom: nomController.text,
            //   images: [
            //     widget.produit != null
            //         ? widget.produit!.images!.first
            //         : widget.imagePath!
            //   ],
            //   categorie: categorieController.text,
            //   prix: double.tryParse(prixController.text) ?? 0.0,
            //   estPopulaire: estPopulaire,
            //   estNouveau: estNouveau,
            // ));
            // Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: widget.onPressedValider,
          child: const Text('Valider'),
        ),
      ],
    );
  }
}
