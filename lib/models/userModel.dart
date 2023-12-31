import 'package:cloud_firestore/cloud_firestore.dart';

import 'CartItemModel.dart';

class Usermodel {
  String? id;
  String? nom;
  String? email;
  String? passwords;
  String? imageBoutique;
  String? descriptionBoutique;
  String? number;
  List<CartItemModel>? cartList;

  Usermodel(
      {this.id,
      this.nom,
      this.email,
      this.passwords,
      this.cartList,
      this.number,
      this.descriptionBoutique,
      this.imageBoutique});

  Usermodel.fromsnapshot(DocumentSnapshot snapshot) {
    nom = (snapshot.data() as dynamic)['name'];
    imageBoutique = (snapshot.data() as dynamic)['imageBoutique'] ?? '';
    descriptionBoutique =
        (snapshot.data() as dynamic)['descriptionBoutique'] ?? '';
    id = (snapshot.data() as dynamic)['id'];
    passwords = (snapshot.data() as dynamic)['password'];
    email = (snapshot.data() as dynamic)['email'];
    number = (snapshot.data() as dynamic)['phone'];
    cartList =
        _convertCartItems((snapshot.data() as dynamic)['cartList'] ?? []);
    // cartList =
    //     List<String>.from((snapshot.data() as dynamic)['cartList'] ?? []);
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.isNotEmpty) {
      for (var element in cartFomDb) {
        _result.add(CartItemModel.fromMap(element));
      }
    }
    return _result;
  }
}
