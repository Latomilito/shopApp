import 'package:cloud_firestore/cloud_firestore.dart';

class BoutiqueModel {
  String? name;
  String? id;
  String? userID;
  String? description;
  String? image;
  BoutiqueModel({
    this.name,
    this.id,
    this.description,
    this.userID,
  });
  BoutiqueModel.fromsnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as dynamic)['name'];
    id = (snapshot.data() as dynamic)['id'];
    userID = (snapshot.data() as dynamic)['userID'];
    description = (snapshot.data() as dynamic)['description'];
    image = (snapshot.data() as dynamic)['image'];
  }
}
