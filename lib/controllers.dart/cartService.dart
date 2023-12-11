import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/userModel.dart';

class CartService {
  Usermodel user = authController.usermodel.value;
  Future<void> ajouterProduitAuPanier(
      String produitID, BuildContext context) async {
    // user.cartList ??= [];
    List<String> cartlist = [];
    // Vérifier si le produit est déjà dans le panier
    if (!user.cartList!.contains(produitID)) {
      cartlist.add(produitID);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text('Produit ajouter au panier'),
        ),
      );
      await FirebaseFirestore.instance.collection('users').doc(user.id).update(
          {'cartList': FieldValue.arrayUnion(cartlist)}).whenComplete(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ce produit est déja dans le panier'),
        ),
      );
    }
  }

  Future<void> removeFromCartInFirestore(
      String userId, String productId) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.update({
        'cartList': FieldValue.arrayRemove([productId]),
      });

      print('Produit supprimé du panier avec succès dans Firebase Firestore');
    } catch (error) {
      print('Erreur lors de la suppression du produit du panier : $error');
    }
  }
}
