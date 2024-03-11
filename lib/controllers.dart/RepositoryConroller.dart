import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/models/productModels.dart';

import '../models/userModel.dart';
import '../models/categorieModel.dart';

class RepositoryController extends GetxController {
  Rx<Produit> produit = Produit().obs;
  Rx<Usermodel> userselected = Usermodel().obs;
  RxString heureSelection = ''.obs;
  static RepositoryController instance = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late StreamSubscription<List<Produit>> trajetsSubscription;
  late StreamSubscription<List<PublicationStandard>> publicationsSubscription;
  late StreamSubscription<List<CategorieModel>> categorisubscription;
  final allproduits = <Produit>[].obs;
  final allpublications = <PublicationStandard>[].obs;
  final categorilist = <CategorieModel>[].obs;
  @override
  void onInit() {
    super.onInit();

    trajetsSubscription = allproduct().listen((List<Produit> data) {
      allproduits.assignAll(data);
    });
    publicationsSubscription =
        allpublication().listen((List<PublicationStandard> data) {
      allpublications.assignAll(data);
    });
    categorisubscription = allcategories().listen((List<CategorieModel> data) {
      categorilist.assignAll(data);
    });
  }

  @override
  void onClose() {
    trajetsSubscription.cancel();
    super.onClose();
  }

  Future<void> ajouterProduit(Produit produit, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
    try {
      return await firestore.collection('produits').doc(produit.id).set({
        'id': produit.id,
        'nom': produit.nom,
        'description': produit.description,
        'images': produit.images,
        'prix': produit.prix,
        'categorie': produit.categorie,
        'estPopulaire': produit.estPopulaire,
        'estNouveau': produit.estNouveau,
      });
    } catch (e) {
      Get.back();
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Erreur',
        desc: "Une erreur s\'est Produite",
        buttons: [
          DialogButton(
            onPressed: () => Get.back(),
            color: Colors.red,
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  Future<void> ajouterPublication(
      PublicationStandard publication, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
    try {
      return await firestore
          .collection('publications')
          .doc(publication.id)
          .set({
        ''
            'id': publication.id,
        'productIds': publication.productIds,
        'description': publication.description,
        'datee': publication.datee
      });
    } catch (e) {
      Get.back();
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Erreur',
        desc: "Une erreur s\'est Produite",
        buttons: [
          DialogButton(
            onPressed: () => Get.back(),
            color: Colors.red,
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  Future<void> ajouterCategorie(
      CategorieModel categorie, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
    try {
      return await firestore.collection('categories').doc(categorie.id).set({
        'id': categorie.id,
        'nom': categorie.name,
        'description': categorie.description,
        'images': categorie.images,
        'userId': categorie.userId
      });
    } catch (e) {
      Get.back();
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Erreur',
        desc: "Une erreur s\'est Produite",
        buttons: [
          DialogButton(
            onPressed: () => Get.back(),
            color: Colors.red,
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  Stream<List<Produit>> allproduct() {
    return _db.collection('produits').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => Produit.fromsnapshot(doc)).toList());
  }

  Stream<List<PublicationStandard>> allpublication() {
    return _db
        .collection('publications')
        .orderBy('datee', descending: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => PublicationStandard.fromsnapshot(doc))
            .toList());
  }

  Stream<List<CategorieModel>> allcategories() {
    return _db
        .collection('categories')
        // .orderBy('datee', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => CategorieModel.fromsnapshot(doc))
            .toList());
  }
}
