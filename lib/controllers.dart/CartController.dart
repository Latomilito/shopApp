import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/models/userModel.dart';
import 'package:uuid/uuid.dart';

import '../models/CartItemModel.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(authController.usermodel, changeCartTotalPrice);
  }

  void addProductToCart(List<Produit> produits, BuildContext context,
      int quantity, String instruction) {
    try {
      for (var i = 0; i < produits.length; i++) {
        if (_isItemAlreadyAdded(produits[i])) {
        } else {
          String itemId = const Uuid().v4();
          authController.updateUserData({
            "cartList": FieldValue.arrayUnion([
              {
                'image': produits[i].images![0],
                "id": itemId,
                "productId": produits[i].id,
                "name": produits[i].nom == ''
                    ? produits[i].categorie
                    : produits[i].nom,
                "quantity": quantity,
                "price": produits[i].prix,
                "cost": produits[i].prix! * quantity,
                "instruction": instruction
              }
            ])
          });
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // backgroundColor: Colors.red,
          content: Text(
            'Produits ajoutés au panier',
            style: TextStyle(
                // color: Colors.white,
                ),
          ),
        ),
      );
    } catch (e) {
      // Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      authController.updateUserData({
        "cartList": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      // debugPrint(e.message);
    }
  }

  changeCartTotalPrice(Usermodel userModel) {
    // totalCartPrice.value = 0.0;
    if (userModel.cartList!.isNotEmpty) {
      for (var cartItem in userModel.cartList!) {
        totalCartPrice.value += cartItem.cost!;
      }
    }
  }

  bool _isItemAlreadyAdded(Produit product) =>
      authController.usermodel.value.cartList!
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item) {
    // Récupérer la liste actuelle
    List<CartItemModel>? cartList = authController.usermodel.value.cartList;

    // Trouver l'index de l'élément à mettre à jour
    int index = cartList!.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      // Mettre à jour localement
      if (item.quantity == 1) {
        cartList.removeAt(index);
        removeCartItem(item);
      } else {
        item.quantity--;
        cartList[index].quantity = item.quantity;
      }

      // Mettre à jour dans Firestore
      authController.updateUserData({"cartList": cartList});
      // changeCartTotalPrice(authController.usermodel.value);
    }
  }

  void increaseQuantity(CartItemModel item) {
    // Récupérer la liste actuelle
    List<CartItemModel>? cartList = authController.usermodel.value.cartList;

    // Trouver l'index de l'élément à mettre à jour
    int index = cartList!.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      // Mettre à jour localement
      item.quantity++;
      cartList[index].quantity = item.quantity;

      // Mettre à jour dans Firestore
      authController.updateUserData({"cartList": cartList});
      // changeCartTotalPrice(authController.usermodel.value);
    }
  }
}
