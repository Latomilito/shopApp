import 'package:cloud_firestore/cloud_firestore.dart';

class categorieModel {
  String? id;
  String? name;
  categorieModel({
    required this.id,
    required this.name,
  });
  categorieModel.fromsnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as dynamic)['name'];
    id = (snapshot.data() as dynamic)['id'];
  }
}
