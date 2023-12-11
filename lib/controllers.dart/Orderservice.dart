import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/orderModel.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrder(Ordermodel order) async {
    String id = const Uuid().v4();
    FirebaseFirestore.instance.collection('orders').doc(id).set({
      'id': id,
      'userId': order.userId,
      'boutiqueID': order.boutiqueID,
      'datee': order.datee,
      'produitsId': order.produitsId,
      'montantTotal': order.montantTotal,
    });
  }
}
