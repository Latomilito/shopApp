import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/CartItemModel.dart';
import 'package:shopapp/pages/AdressePage.dart';
import 'package:shopapp/widget/panierWidget.dart';

class CommandeInfoPage extends StatefulWidget {
  @override
  _CommandeInfoPageState createState() => _CommandeInfoPageState();
}

class _CommandeInfoPageState extends State<CommandeInfoPage> {
  FocusNode _focusNode = FocusNode();
  List<CartItemModel>? cartitems;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartitems = authController.usermodel.value.cartList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Informations de Commande',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adresse',
                  style: GoogleFonts.acme(fontSize: 17),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const AdressePage();
                    }));
                    _focusNode.unfocus();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chez moi , pharmacie Dan gao',
                            style: GoogleFonts.acme(
                                fontSize: 17,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                          const Icon(Icons.mode_edit_outline_outlined)
                        ],
                      )),
                ),
                Text(
                  'Coupon',
                  style: GoogleFonts.acme(fontSize: 17),
                ),
                Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    // height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Form(
                      // key: _form,
                      child: TextFormField(
                        focusNode: _focusNode,
                        // validator: ValidationBuilder().required().build(),
                        controller: authController.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.acme(fontSize: 17),
                            hintText: '*****',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none),
                      ),
                    )),
                // Card(
                //   elevation: 0,
                //   child: ListTile(
                //     title: const Text('Coupon'),
                //     // leading: const Icon(
                //     //   Icons.password_outlined,
                //     // ),
                //     subtitle: TextField(
                //       focusNode: _focusNode,
                //       decoration: const InputDecoration(
                //           hintText: 'Appliquez un code promo'),
                //     ),
                //     // trailing: ElevatedButton(
                //     //   onPressed: () {
                //     //     _focusNode.unfocus();
                //     //   },
                //     //   child: const Text('OK'),
                //     // ),
                //   ),
                // ),
                // Card(
                //   elevation: 0,
                //   child: ListTile(
                //     title: const Text('instructions'),
                //     // leading: const Icon(
                //     //   Icons.password_outlined,
                //     // ),
                //     subtitle: TextField(
                //       focusNode: _focusNode,
                //       decoration:
                //           const InputDecoration(hintText: 'autres remarques'),
                //     ),
                //     trailing: ElevatedButton(
                //       onPressed: () {
                //         _focusNode.unfocus();
                //       },
                //       child: const Text('OK'),
                //     ),
                //   ),
                // ),
                const Text(
                  'Contenu du panier',
                  style: TextStyle(fontSize: 16),
                ),
                Obx(
                  () => Column(
                    children: authController.usermodel.value.cartList!
                        .map(
                          (cartitem) =>
                              panierWidget(cartitem: cartitem, quantite: 1),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            title: const Text(
              'Total : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Obx(
              () => Text(
                '${cartController.totalCartPrice} \$',
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                HapticFeedback.vibrate();
                _focusNode.unfocus();
              },
              child: const Text(
                'Suivant',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
