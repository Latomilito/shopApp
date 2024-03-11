import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/pages/ComSheet.dart';

class OfferPublishScreen extends StatefulWidget {
  const OfferPublishScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OfferPublishScreenState createState() => _OfferPublishScreenState();
}

class _OfferPublishScreenState extends State<OfferPublishScreen> {
  // // Set<String> categoriesSet = repositoryController.allproduits
  //     .map((element) => element.categorie!)
  //     .toSet();
  int? selectedRadio;
  bool selectedFirsteValue = true;
  bool selectedEndValue = false;
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double? pourcentage;
  TimeOfDay? timeDebut;
  TimeOfDay? timeFin;
  FocusNode _focusNode = FocusNode();
  List<Produit> produitSelectionner = [];
  List<String> categoriesselectionner = [];
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  List<String> _selectedProducts = [];
  File? _selectedImage;
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

  Future<void> _selectTime(BuildContext context, {bool? isDebut}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        isDebut == true ? timeDebut = pickedTime : timeFin = pickedTime;
      });
    }
  }

  // Placeholder for product list (you should replace this with your actual product list)
  final List<String> _allProducts = [
    "Product A",
    "Product B",
    "Product C",
    "Product D"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Publier une Offre',
          style: GoogleFonts.acme(),
        ),
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
                        Text('Ajouter une image')
                      ],
                    )),
              if (_selectedImage != null)
                GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    _pickImages();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 4.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0)),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : const Icon(
                                Icons.add_a_photo,
                                size: 50,
                              ),
                      ),
                      Positioned(
                          right: 10,
                          top: 1,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            icon: const Icon(
                              Icons.highlight_remove_outlined,
                              size: 50,
                            ),
                          )),
                    ],
                  ),
                ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value as int;
                      });
                    },
                  ),
                  const Text(
                    'Réduction générale sur les achats',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value as int;
                      });
                    },
                  ),
                  const Text(
                    'Réduction sur des Catégories',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value as int;
                      });
                    },
                  ),
                  const Text('Réduction sur des produits',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
              // const SizedBox(height: 16.0),
              const SizedBox(
                height: 5,
              ),
              if (selectedRadio == 2 && categoriesselectionner.isEmpty)
                OutlinedButton(
                  onPressed: () => _selectCategories(context),
                  child: Text(
                    'Selectionner les catégories',
                    style: TextStyle(
                      color: selectedRadio == 2 ? Colors.red : Colors.blue,
                    ),
                  ),
                ),
              if (selectedRadio == 3 && produitSelectionner.isEmpty)
                OutlinedButton(
                  onPressed: () => _selectProducts(context),
                  child: Text(
                    'Sélectionner les Produits',
                    style: TextStyle(
                      color: selectedRadio == 3 ? Colors.red : Colors.blue,
                    ),
                  ),
                ),
              if (categoriesselectionner.isNotEmpty && selectedRadio == 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 10),
                      child: Row(
                        children: [
                          const Text(
                            'Catégorie(s) selectionnée(s)',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          Text(
                            categoriesselectionner.length.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 50,
                      ),
                      itemCount: categoriesselectionner.length + 1,
                      itemBuilder: (context, index) {
                        if (index == categoriesselectionner.length) {
                          return InkWell(
                              onTap: () {
                                _selectCategories(context);
                              },
                              child: const Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                elevation: 0,
                                child: Center(
                                  child: Icon(Icons.add),
                                ),
                              ));
                        } else {
                          String categorie = categoriesselectionner[index];
                          return Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 0,
                            color: Colors.grey.withOpacity(0.2),
                            child: Center(
                                child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    categorie,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                // const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      categoriesselectionner.remove(categorie);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                        Icons.highlight_remove_outlined)),
                              ],
                            )),
                          );
                        }
                      },
                    ),
                  ],
                ),
              produitSelectionner.isNotEmpty && selectedRadio == 3
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Produits selectionnés(s)',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Text(
                                produitSelectionner.length.toString(),
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  mainAxisExtent: 120),
                          itemCount: produitSelectionner.length +
                              1, // +1 pour le bouton "Add"
                          itemBuilder: (context, index) {
                            if (index == produitSelectionner.length) {
                              return InkWell(
                                onTap: () {
                                  _selectProducts(context);
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    const Text('')
                                  ],
                                ),
                              );
                            } else {
                              Produit produit = produitSelectionner[index];
                              return GridTile(
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(0)),
                                            child: CachedNetworkImage(
                                              imageUrl: produit.images!.first,
                                              height: double.maxFinite,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0))),
                                          margin: EdgeInsets.zero,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                pourcentage != null
                                                    ? '${(produit.prix! - (pourcentage! * produit.prix!) / 100)}'
                                                    : produit.prix.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: pourcentage != null
                                                        ? Colors.red
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Center(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          produitSelectionner.removeAt(index);
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.highlight_remove_outlined,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            size: 40,
                                          ),
                                          const Text('')
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 0,
              ),
              const Row(
                children: [
                  Text(
                    'Descriptions',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  // focusNode: _focusNode,
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    // labelText: 'Description de la Promotion',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Text(
                    'Pourcentage',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        pourcentage = null;
                      });
                    } else {
                      setState(() {
                        pourcentage = double.parse(value);
                      });
                    }
                  },
                  // focusNode: _focusNode,
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // labelText: 'Pourcentage de Réduction',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(height: 5),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisExtent: 200,
                ),
                children: [
                  Card(
                    // color: Colors.grey.withOpacity(0.2),
                    elevation: 0,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Date de Début',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          height: 50,
                          child: Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                elevation: 0,
                                backgroundColor: Colors.grey.withOpacity(0.2)),
                            onPressed: () {
                              _selectStartDate(context);
                            },
                            child: Center(
                                child: Text(
                              _selectedStartDate == null
                                  ? 'Date'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(_selectedStartDate!),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: _selectedStartDate == null
                                      ? Colors.grey
                                      : Colors.blue),
                            )),
                          )),
                          // color: Colors.grey.withOpacity(0.2)
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          height: 50,
                          child: Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                elevation: 0,
                                backgroundColor: Colors.grey.withOpacity(0.2)),
                            onPressed: () {
                              _selectTime(context, isDebut: true);
                            },
                            child: Center(
                                child: Text(
                              timeDebut == null
                                  ? 'Heure'
                                  : timeDebut!.format(context),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: timeDebut == null
                                      ? Colors.grey
                                      : Colors.blue),
                            )),
                          )),
                          // color: Colors.grey.withOpacity(0.2)
                        ),
                      ],
                    ),
                  ),
                  Card(
                    // color: Colors.grey.withOpacity(0.2),
                    elevation: 0,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Date de fin',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          height: 50,
                          child: Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                elevation: 0,
                                backgroundColor: Colors.grey.withOpacity(0.2)),
                            onPressed: () {
                              _selectEndDate(context);
                            },
                            child: Center(
                                child: Text(
                              _selectedEndDate == null
                                  ? 'Date'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(_selectedEndDate!),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: _selectedEndDate == null
                                      ? Colors.grey
                                      : Colors.blue),
                            )),
                          )),
                          // color: Colors.grey.withOpacity(0.2)
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          height: 50,
                          child: Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                elevation: 0,
                                backgroundColor: Colors.grey.withOpacity(0.2)),
                            onPressed: () {
                              _selectTime(context, isDebut: false);
                            },
                            child: Center(
                                child: Text(
                              timeFin == null
                                  ? 'Heure'
                                  : timeFin!.format(context),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: timeFin == null
                                      ? Colors.grey
                                      : Colors.blue),
                            )),
                          )),
                          // color: Colors.grey.withOpacity(0.2)
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                onPressed: () => _publishOffer(),
                child: const Text(
                  'Publier l\'Offre',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectProducts(BuildContext context) async {
    List<Produit>? produitsSelectionnes = await afficherListeProduits(context);
    if (produitsSelectionnes != null) {
      if (produitSelectionner.isNotEmpty) {
        for (Produit produit in produitsSelectionnes) {
          if (produitSelectionner
              .every((element) => element.id != produit.id)) {
            setState(() {
              produitSelectionner.addAll(produitsSelectionnes);
            });
          } else {
            // setState(() {
            //   produitSelectionner = produitsSelectionnes;
            // });
          }
        }
      } else {
        setState(() {
          produitSelectionner = produitsSelectionnes;
        });
      }
    } else {
      print('Aucun produit sélectionné.');
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  void _publishOffer() {
    _focusNode.unfocus();
    // Validate input and publish the offer to Firestore
    // ...

    // Reset state after publishing
    _imageController.clear();
    _descriptionController.clear();
    _discountController.clear();
    _selectedStartDate = null;
    _selectedEndDate = null;
    _selectedProducts.clear();
  }

  Future<void> _selectCategories(BuildContext context) async {
    List<String>? categoriesselectionnes =
        await afficherListeCategorie(context);
    if (categoriesselectionnes != null) {
      if (categoriesselectionner.isNotEmpty) {
        for (String categorie in categoriesselectionnes) {
          if (categoriesselectionner
              // ignore: unrelated_type_equality_checks
              .every((element) => element != categorie)) {
            setState(() {
              categoriesselectionner.addAll(categoriesselectionnes);
            });
          } else {
            // setState(() {
            //   produitSelectionner = produitsSelectionnes;
            // });
          }
        }
      } else {
        setState(() {
          categoriesselectionner = categoriesselectionnes;
        });
      }
    } else {
      print('Aucun produit sélectionné.');
    }
  }
}
