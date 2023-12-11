import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/productModels.dart';

class Ordermodel {
  String? id;
  String? userId;
  List<String>? produitsId;
  DateTime? dateOrder;
  double? montantTotal;
  String? datee;
  String? boutiqueID;

  Ordermodel(
      {this.id,
      this.userId,
      this.produitsId,
      this.dateOrder,
      this.montantTotal,
      this.datee,
      this.boutiqueID});

  Ordermodel.fromSnapshot(DocumentSnapshot snapshot) {
    id = (snapshot.data() as dynamic)['id'];
    produitsId =
        List<String>.from((snapshot.data() as dynamic)['productIds'] ?? []);
    dateOrder = DateTime.parse((snapshot.data() as dynamic)['datee']);
    userId = (snapshot.data() as dynamic)['userId'];
    boutiqueID = (snapshot.data() as dynamic)['boutiqueID'];
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'userId': userId,
  //     'produits': produits.map((produit) => produit.toMap()).toList(),
  //     'dateOrder': dateOrder,
  //     'montantTotal': montantTotal,
  //   };
  // }
}
