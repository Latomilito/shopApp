import 'package:cloud_firestore/cloud_firestore.dart';

class CategorieModel {
  String? id;
  String? name;
  String? description;
  String? userId;
  List<String>? images;
  CategorieModel(
      {this.id, this.name, this.description, this.images, this.userId});
  CategorieModel.fromsnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as dynamic)['name'];
    id = (snapshot.data() as dynamic)['id'];
    description = (snapshot.data() as dynamic)['description'];
    images = List<String>.from((snapshot.data() as dynamic)['images'] ?? []);
    userId = (snapshot.data() as dynamic)['userId'];
  }
}
