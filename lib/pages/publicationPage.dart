import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/widget/bottomsheeet.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../widget/ChampImage.dart';
import '../widget/ChampNomProduit.dart';
import '../widget/Champdescription.dart';
import '../widget/Champprix.dart';
import '../widget/SelectCategorie.dart';

class PublicationPage extends StatefulWidget {
  Produit? produit;
  PublicationPage({super.key, this.produit});

  @override
  // ignore: library_private_types_in_public_api
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  int _selectedIndex = 0;
  TextEditingController nom = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController description1 = TextEditingController();
  TextEditingController categorie = TextEditingController();
  TextEditingController categorieSame = TextEditingController();
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();

  bool _imagesSelected = false;
  bool isSameCategorie = false;
  List<XFile?> images = [];
  List<Produit> produitSelectionner = [];
  PublicationStandard? publication;
  Future<void> _pickImages(
      {String? categorie,
      String? prixControllerCategorie,
      String? prix}) async {
    try {
      List<XFile>? pickedMultipleImage = await ImagePicker().pickMultiImage();
      if (pickedMultipleImage != null && pickedMultipleImage.isNotEmpty) {
        for (XFile file in pickedMultipleImage) {
          await _showImageInputDialog(
              imagePath: file.path,
              categorie: categorie,
              prixControllerCategorie: prix);
        }
        setState(() {
          images = pickedMultipleImage;
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection des images: $e');
    }
  }

  Future<void> _showImageInputDialog(
      {String? imagePath,
      Produit? produit,
      String? categorie,
      String? prixControllerCategorie}) async {
    TextEditingController nomController = TextEditingController();
    TextEditingController prixController = TextEditingController();
    TextEditingController categorieController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    bool estPopulaire = false;
    bool estNouveau = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (categorie != null) {
          categorieController.text = categorie;
        }
        if (produit != null) {
          nomController.text = produit.nom!;
          categorieController.text = produit.categorie!;
        }
        return AlertDialog(
          title: const Text('Remplissez les champs'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  produit == null
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          height: 100,
                          // width: double.infinity,
                        )
                      : Image.file(
                          File(produit.images!.first),
                          fit: BoxFit.cover,
                          height: 100,
                          // width: double.infinity,
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
                          isMEme: isSameCategorie,
                          prixControllerCategorie: prixControllerCategorie,
                          controller: prixController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                prixController.text = value;
                              });
                            }
                            // Ajoutez d'autres validations ici, par exemple, pour s'assurer que le prix est un nombre valide.
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
                  const SizedBox(height: 10),
                  SelecteurCategorieProduit(
                    categorieselected: categorie,
                    categories: categoriesSet.toList(),
                    onSelect: (selectedCategory) {
                      categorieController.text = selectedCategory;
                      categoriesSet.add(selectedCategory);
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                produitSelectionner.removeWhere((element) =>
                    element.images!.first == produit!.images!.first);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Supprimer'),
            ),
            TextButton(
              onPressed: () {
                String id = const Uuid().v4();
                produit != null
                    ? produitSelectionner.removeWhere((element) =>
                        element.images!.first == produit.images!.first)
                    : null;
                produitSelectionner.add(Produit(
                    id: id,
                    nom: nomController.text,
                    images: [
                      produit != null ? produit.images!.first : imagePath!
                    ],
                    categorie: categorieController.text,
                    prix: double.tryParse(prixController.text) ?? 0.0));
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                String id = const Uuid().v4();
                produit != null
                    ? produitSelectionner.removeWhere((element) =>
                        element.images!.first == produit.images!.first)
                    : null;
                produitSelectionner.add(Produit(
                    id: id,
                    nom: nomController.text,
                    images: [
                      produit != null ? produit.images!.first : imagePath!
                    ],
                    categorie: categorieController.text,
                    prix: double.tryParse(prixController.text) ?? 0.0));
                // Utilisez les valeurs des champs de texte comme nécessaire
                // par exemple, nomController.text, prixController.text, categorieController.text

                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  String selectedCategory = ''; // Ajout de la variable selectedCategory
  TextEditingController prixControllerCategorie = TextEditingController();
  String prixMeme = '';
  // ...

  Future _showCategoryDialog() async {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionner une catégorie'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SelecteurCategorieProduit(
                  categories: categoriesSet.toList(),
                  onSelect: (selectedCategory) {
                    setState(() {
                      this.selectedCategory = selectedCategory;
                      categoriesSet.add(selectedCategory);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ChampPrixProduit(
                  prixMeme: (value) {
                    setState(() {
                      prixMeme = value!;
                    });
                  },
                  isMEme: isSameCategorie,
                  controller: prixControllerCategorie,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Le prix du produit ne peut pas être vide';
                    }
                    // Ajoutez d'autres validations ici, par exemple, pour s'assurer que le prix est un nombre valide.
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedCategory);
                produitSelectionner.isNotEmpty
                    ? _pickAdditionalImages(
                        prix: prixMeme,
                        categorie: selectedCategory,
                        prixControllerCategorie: prixControllerCategorie.text)
                    : _pickImages(
                        prix: prixMeme,
                        categorie: selectedCategory,
                        prixControllerCategorie: prixControllerCategorie.text);
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAdditionalImages(
      {String? categorie,
      String? prixControllerCategorie,
      String? prix}) async {
    try {
      List<XFile>? additionalImages = await ImagePicker().pickMultiImage();
      if (additionalImages != null && additionalImages.isNotEmpty) {
        for (XFile file in additionalImages) {
          await _showImageInputDialog(
              imagePath: file.path,
              categorie: categorie,
              prixControllerCategorie: prix);
        }
        setState(() {
          images.addAll(additionalImages);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection d\'images supplémentaires: $e');
    }
  }

  List<String>? nouvellesImages;
  void _onImagesSelected(List<File?> images) {
    setState(() {
      _imagesSelected = images.any((image) => image != null);
    });
  }

  List<String> imageUrls =
      List.filled(3, ''); // Liste pour stocker les URL des images
  // bool estPopulaire =
  //     false; // Booléen pour indiquer si le produit est populaire
  // bool estNouveau = false; // Booléen pour indiquer si le produit est nouveau
  String? _imageValidationError;

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(
          'Progression du téléchargement: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
    });
    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  String? validateImages(List<File?> images) {
    if (images.any((image) => image != null)) {
      return null; // Au moins une image a été sélectionnée
    }
    return 'Sélectionnez au moins une image';
  }

  String onDateSelected(DateTime date) {
    // Formater la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);

    return formattedDate;
  }

  Future<void> ajouterProduits(
      List<Produit> produits, BuildContext context) async {
    Get.defaultDialog(
        title: 'chargement..',
        content: const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ));
    for (int i = 0; i < produits.length; i++) {
      Produit produit = produits[i];

      final downloadUrl =
          await uploadImageToFirebaseStorage(File(produit.images!.first));
      produit.images = [downloadUrl];

      // ignore: use_build_context_synchronously
      await repositoryController.ajouterProduit(produit, context);
    }

    produits.clear();
    setState(() {});
    Get.back();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void onSelectCategorie(String selectedCategory) {
    setState(() {
      categorie.text = selectedCategory;
    });
  }

  void initialize(Produit produit) {
    categorie.text = produit.categorie!;
    description1.text = produit.description!;
    prix.text = produit.prix!.toString();
    nom.text = produit.nom!;

    imageUrls = produit.images!;
    // estPopulaire = produit.estPopulaire!;
    // estNouveau = produit.estNouveau!;
    nouvellesImages = List<String>.from(widget.produit!.images!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.produit != null ? initialize(widget.produit!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Ajouter un produit',
          style: GoogleFonts.acme(fontSize: 17, color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () async {
                  bool? addSameCategory = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'Ajouter des produits de la même catégorie ?'),
                        content: const Text(
                            'Voulez-vous ajouter des produits de la même catégorie ?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Non'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(true);
                              setState(() {
                                categorieSame.text = '';
                                prixMeme = '';
                                prixControllerCategorie.clear();
                              });

                              // Afficher le dialogue de sélection de catégorie
                              String? selectedCategory =
                                  await _showCategoryDialog();

                              if (selectedCategory != null) {
                                setState(() {
                                  isSameCategorie = true;
                                  categorieSame.text = selectedCategory;
                                });
                              }
                            },
                            child: const Text('Oui'),
                          ),
                        ],
                      );
                    },
                  );

                  if (addSameCategory != null && !addSameCategory) {
                    // Ajouter seulement des images
                    produitSelectionner.isNotEmpty
                        ? _pickAdditionalImages()
                        : _pickImages();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      produitSelectionner.isNotEmpty
                          ? 'Ajouter d\'autres Produits'
                          : 'Ajouter des produits',
                    ),
                  ],
                ),
              ),
              if (produitSelectionner.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: description1,
                    decoration: const InputDecoration(
                      labelText: 'Description de la publication',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Vous pouvez traiter la nouvelle catégorie ici si nécessaire
                    },
                  ),
                ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    showPublicationActionsBottomSheet(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Faire une annonce '),
                    ],
                  )),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Faire une offre '),
                    ],
                  )),
              if (produitSelectionner.isNotEmpty)
                Expanded(
                    child: GridView.builder(
                        itemCount: produitSelectionner.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (buildContext, index) {
                          Produit produit = produitSelectionner[index];

                          // Convertir XFile en File
                          File file = File(produit.images!.first);
                          return GestureDetector(
                            onTap: () {
                              _showImageInputDialog(produit: produit);
                            },
                            child: Card(
                              elevation: 5,
                              // decoration: BoxDecoration(
                              //     border:
                              //         Border.all(width: 1, color: Colors.grey)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(2),
                                      child: Image.file(
                                        file,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1),
                                    width: double.infinity,
                                    color: Colors.orange,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          produit.nom != '' ? produit.nom! : '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                        Text(
                                          produit.prix != 0.0
                                              ? produit.prix.toString()
                                              : '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                        Text(
                                          produit.categorie != ''
                                              ? produit.categorie!
                                              : '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              Text(
                _imageValidationError ?? '',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (produitSelectionner.isNotEmpty)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        description1.text.isNotEmpty) {
                      publication = PublicationStandard(
                          datee: onDateSelected(DateTime.now()),
                          description: description1.text.trim(),
                          id: DateTime.now().toString(),
                          productIds:
                              produitSelectionner.map((e) => e.id!).toList());

                      ajouterProduits(produitSelectionner, context)
                          .whenComplete(() => repositoryController
                              .ajouterPublication(publication!, context));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ajouter',
                        style:
                            GoogleFonts.acme(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
