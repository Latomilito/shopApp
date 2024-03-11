import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/widget/produiWidget.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  List<Produit> selectedProducts = [];
  int selectedIndex = -1;
  double? prixSelected;
  List<double> prixx = [
    5000.0,
    10000.0,
  ];
  final ValueNotifier<List<XFile>> files = ValueNotifier<List<XFile>>([]);
  File? _selectedImage;
  final TextEditingController _nouveauPrixController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('categories/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(
          'Progression du téléchargement: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
    });
    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
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

  void _afficherDialogueCreationPrix() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Créer un prix"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nouveauPrixController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Nouveau prix"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Annuler l'opération
              Navigator.pop(context);
            },
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Valider l'opération et ajouter le nouveau prix
              String nouveauPrix = _nouveauPrixController.text;
              prixx.add(double.parse(nouveauPrix));
              setState(() {});

              Navigator.pop(context);
            },
            child: const Text(
              "Valider",
            ),
          ),
        ],
      ),
    );
  }

  // XFile? images;
  Future<void> _pickImages() async {
    try {
      XFile? imagepiked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepiked != null) {
        setState(() {
          _selectedImage = File(imagepiked.path);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection des images: $e');
    }
  }

  dynamic updateProductDetails(newName, newDescription, image, prix, id) {
    setState(() {
      // Créez un nouvel objet Produit avec les nouvelles informations
      Produit newProduct = Produit(
          id: id,
          images: [image], // Mettez à jour l'image si elle existe
          nom: newName,
          prix: prix,
          categorie: _nameController.text,
          description: newDescription);

      // Remplacez l'objet Produit existant dans la liste par le nouveau produit
      // ignore: unrelated_type_equality_checks
      int index = produits.indexOf(
          produits.firstWhere((element) => element.images!.first == image));
      produits[index] = newProduct;
    });
  }

  List<Produit> produits = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Ajouter une Collection',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_selectedImage == null)
                OutlinedButton(
                    onPressed: () {
                      _pickImages();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Ajouter une image'),
                      ],
                    )),
              if (_selectedImage != null)
                GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    _pickImages();
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.3,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(0),
                    // ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Nom de la collection',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      // focusNode: _focusNode,
                      // validator: ValidationBuilder().required().build(),
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              // const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      // focusNode: _focusNode,
                      // validator: ValidationBuilder().required().build(),
                      controller: _descriptionController,
                      maxLines: 3,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Prix des produits',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: prixx.length + 1,
                  itemBuilder: (context, index) {
                    if (index == prixx.length) {
                      return GestureDetector(
                        onTap: _afficherDialogueCreationPrix,
                        child: Card(
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0,
                          child: const SizedBox(
                            height: 35,
                            width: 70,
                            child: Icon(Icons.add),
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          prixSelected = prixx[index];
                        });
                      },
                      child: Card(
                        elevation: 0,
                        color: index == selectedIndex
                            ? Colors.red
                            : Colors.grey.withOpacity(0.3),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 35,
                          alignment: Alignment.center,
                          child: Text(
                            '${prixx[index]} Fr',
                            style: TextStyle(
                                fontSize: 16,
                                color: index == selectedIndex
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                  // height: 10,
                  ),

              // const SizedBox(height: 10),
              if (produits.isNotEmpty)
                Column(
                  children: [
                    // const Text(
                    //   'Parcourez et renseignez les informations manquantes de chaques produits suivants',
                    //   style: TextStyle(
                    //     fontSize: 17,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 8),
                      child: Row(
                        children: [
                          const Text(
                            'Produits',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          if (prixSelected != null)
                            const Text('Même prix pour tous ?'),
                          Checkbox(value: false, onChanged: (value) {})
                        ],
                      ),
                    ),
                    GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height / 3.8,
                        ),
                        children: [
                          ...produits.map((e) {
                            return ProduitWidget(
                              prixSelected: prixSelected,
                              onSelect: (isSelected) {
                                if (isSelected) {
                                  Produit produitPrix = Produit(
                                      categorie: e.categorie,
                                      prix: prixSelected,
                                      description: e.description,
                                      nom: e.nom,
                                      images: e.images,
                                      id: e.id);
                                  int index = produits.indexOf(
                                      produits.firstWhere((element) =>
                                          element.id == produitPrix.id));
                                  if (prixSelected != null) {
                                    produits[index] = produitPrix;
                                    setState(() {});
                                  }

                                  selectedProducts.add(e);
                                } else {
                                  Produit produitPrix = Produit(
                                      categorie: e.categorie,
                                      prix: 0.0,
                                      description: e.description,
                                      nom: e.nom,
                                      images: e.images,
                                      id: e.id);
                                  int index = produits.indexOf(
                                      produits.firstWhere((element) =>
                                          element.id == produitPrix.id));
                                  produits[index] = produitPrix;
                                  setState(() {});
                                  selectedProducts.remove(e);
                                }
                                setState(() {});
                              },
                              isPageDetails3: false,
                              isAllList: true,
                              isCreateCategorie: true,
                              isFromcategorie: false,
                              produit: e,
                              onUpdateProductDetails: updateProductDetails,
                            );
                          }).toList(),
                          Card(
                            color: Colors.grey.withOpacity(0.3),
                            elevation: 0,
                            child: IconButton(
                              onPressed: () async {
                                List<XFile>? result =
                                    await ImagePicker().pickMultiImage();

                                if (result != null) {
                                  for (XFile file in result) {
                                    String id = const Uuid().v4();
                                    Produit produit = Produit(
                                        description: '',
                                        prix: 0.0,
                                        id: id,
                                        images: [file.path],
                                        nom: '',
                                        categorie: _nameController.text);
                                    produits.add(produit);
                                  }
                                  setState(() {});
                                  // Scroll back to the first image
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          )
                        ]),
                  ],
                ),
              if (produits.isEmpty)
                OutlinedButton(
                    onPressed: () async {
                      List<XFile>? result =
                          await ImagePicker().pickMultiImage();
                      // List<File>? result = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const WhatsappCamera(),
                      //   ),
                      // );
                      if (result != null) {
                        files.value.addAll(result);
                        for (XFile file in files.value) {
                          String id = const Uuid().v4();
                          Produit produit = Produit(
                              description: '',
                              prix: 0.0,
                              id: id,
                              images: [file.path],
                              nom: '',
                              categorie: _nameController.text);
                          produits.add(produit);
                        }
                        setState(() {});
                        // Scroll back to the first image
                      }
                    },
                    child: files.value.isEmpty
                        ? const Text('Ajouter des produits')
                        : const Text('Ajouter d\'autres produits')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.red),
                onPressed: () {
                  HapticFeedback.vibrate();
                  ajouterProduits(produits, context);
                },
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
