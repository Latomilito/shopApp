import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  String? id;
  String? nom;
  double? prix;
  String? description;
  String? categorie;
  List<String>? images;
  bool? estPopulaire;
  bool? estNouveau;
  int? quantity;
  String? userId;

  Produit({
    this.quantity,
    this.id,
    this.nom,
    this.prix,
    this.description,
    this.images,
    this.categorie,
    this.estNouveau,
    this.estPopulaire,
    this.userId,
  });
  Produit.fromsnapshot(DocumentSnapshot snapshot) {
    nom = (snapshot.data() as dynamic)['nom'];
    userId = (snapshot.data() as dynamic)['userId'] ?? '';
    categorie = (snapshot.data() as dynamic)['categorie'];
    // prix = double.parse((snapshot.data() as dynamic)['prix']);

    prix = (snapshot.data() as dynamic)['prix'];
    // prix = 0.0;
    description = (snapshot.data() as dynamic)['description'];
    images = List<String>.from((snapshot.data() as dynamic)['images'] ?? []);
    id = (snapshot.data() as dynamic)['id'];
    estPopulaire = (snapshot.data() as dynamic)['estPopulaire'] ?? false;
    estNouveau = (snapshot.data() as dynamic)['estNouveau'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prix': prix,
      'description': description,
      'images': images,
      'categorie': categorie
    };
  }
}
