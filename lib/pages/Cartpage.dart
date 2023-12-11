import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/userModel.dart';
import 'package:shopapp/pages/commandeInfo.dart';

// import '../Productmodels.dart';
import '../models/productModels.dart';
import '../widget/panierWidget.dart';

class PagePanier extends StatefulWidget {
  final List<Produit>? produitsPanier;

  PagePanier({this.produitsPanier});

  @override
  State<PagePanier> createState() => _PagePanierState();
}

class _PagePanierState extends State<PagePanier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Usermodel>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              // .orderBy('datee', descending: true)
              .snapshots()
              .map((querySnapshot) => querySnapshot.docs
                  .map((doc) => Usermodel.fromsnapshot(doc))
                  .toList()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Usermodel> users = snapshot.data!;
            Usermodel user = users.firstWhere(
                (element) => element.id == authController.usermodel.value.id);

            return ListView.builder(
              itemCount: user.cartList!.length,
              itemBuilder: (context, index) {
                return ApercuPanier(
                    cartitem: user.cartList![index], quantite: 1);
              },
            );
          }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Total :${cartController.totalCartPrice} \$',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CommandeInfoPage();
                }));
              },
              child: const Text(
                'Passer à la commande',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
