import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/CartItemModel.dart';
import 'package:shopapp/widget/panierInfo.dart';
import 'package:shopapp/widget/panierWidget.dart';

class CommandeInfoPage extends StatefulWidget {
  @override
  _CommandeInfoPageState createState() => _CommandeInfoPageState();
}

class _CommandeInfoPageState extends State<CommandeInfoPage> {
  List<CartItemModel>? cartitems;
  TextEditingController _numeroController = TextEditingController();
  String _heureLivraison = '09:00 AM'; // Heure de livraison par défaut
  String _jourLivraison = 'Lundi'; // Jour de livraison par défaut
  bool _autrePersonne = false; // Indique si c'est une autre personne
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartitems = authController.usermodel.value.cartList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Informations de Commande',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: authController.usermodel.value.cartList!
                      .map(
                        (cartitem) =>
                            ApercuPanier(cartitem: cartitem, quantite: 1),
                      )
                      .toList(),
                ),
              ),
              // const SizedBox(
              //   height: 200,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => Text(
                'Total :${cartController.totalCartPrice} \$',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return CommandeInfoPage();
                // }));
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
