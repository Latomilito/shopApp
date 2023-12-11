import 'package:cloud_firestore/cloud_firestore.dart';

class PublicationStandard {
  String? id;
  String? description;
  List<String>? productIds;
  String? datee;
  DateTime? date;
  String? userID;
  // List<String>? images;

  PublicationStandard(
      {this.userID, this.id, this.description, this.productIds, this.datee
      //  this.images,
      });
  PublicationStandard.fromsnapshot(DocumentSnapshot snapshot) {
    id = (snapshot.data() as dynamic)['id'];
    userID = (snapshot.data() as dynamic)['userID'];
    description = (snapshot.data() as dynamic)['description'];
    productIds =
        List<String>.from((snapshot.data() as dynamic)['productIds'] ?? []);
    date = DateTime.parse((snapshot.data() as dynamic)['datee']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productIds': productIds,
      'description': description,
      'datee': datee
    };
  }
}

class PublicationAfiche {
  String? id;
  String? description;
  String? userID;
  String? datee;
  DateTime? date;
  List<String>? images;

  PublicationAfiche({this.id, this.description, this.datee
      //  this.images,
      });
  PublicationAfiche.fromsnapshot(DocumentSnapshot snapshot) {
    images = List<String>.from((snapshot.data() as dynamic)['images'] ?? []);
    id = (snapshot.data() as dynamic)['id'];
    userID = (snapshot.data() as dynamic)['userID'];
    description = (snapshot.data() as dynamic)['description'];

    date = DateTime.parse((snapshot.data() as dynamic)['datee']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'description': description,
      'datee': datee
    };
  }
}
