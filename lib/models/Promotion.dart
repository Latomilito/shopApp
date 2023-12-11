import 'package:cloud_firestore/cloud_firestore.dart';

class Promotion {
  String? id;
  String? image;
  List<String>? productsInPromotion;
  double? discountPercentage;
  DateTime? startDate;
  DateTime? endDate;

  Promotion({
    this.id,
    this.image,
    this.productsInPromotion,
    this.discountPercentage,
    this.startDate,
    this.endDate,
  });

  // Méthode pour vérifier si la promotion est encore valide
  bool isValid() {
    final currentDate = DateTime.now();
    return startDate != null &&
        endDate != null &&
        currentDate.isAfter(startDate!) &&
        currentDate.isBefore(endDate!);
  }

  // Méthode pour appliquer la réduction à un montant
  double applyDiscount(double amount) {
    if (isValid() && discountPercentage != null) {
      final discountAmount = (amount * discountPercentage!) / 100;
      return amount - discountAmount;
    }
    return amount;
  }

  // Convertir la promotion en une carte pour le stockage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'productsInPromotion': productsInPromotion,
      'discountPercentage': discountPercentage,
      'startDate': startDate?.toUtc(),
      'endDate': endDate?.toUtc(),
    };
  }

  // Créer une promotion à partir d'une carte
  Promotion.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
    productsInPromotion = List<String>.from(map['productsInPromotion'] ?? []);
    discountPercentage = map['discountPercentage']?.toDouble();
    startDate = (map['startDate'] as Timestamp?)?.toDate();
    endDate = (map['endDate'] as Timestamp?)?.toDate();
  }
}
