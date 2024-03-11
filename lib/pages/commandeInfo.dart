import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/CartItemModel.dart';
import 'package:shopapp/pages/AdressePage.dart';
import 'package:shopapp/widget/panierWidget.dart';

class CommandeInfoPage extends StatelessWidget {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Informations de Commande',
            style: GoogleFonts.acme(),
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
        body: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Adresse',
                  //   style: GoogleFonts.acme(fontSize: 17),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     HapticFeedback.vibrate();
                  //     Navigator.of(context).push(
                  //         MaterialPageRoute(builder: (BuildContext context) {
                  //       return const AdressePage();
                  //     }));
                  //     _focusNode.unfocus();
                  //   },
                  //   child: Container(
                  //       padding: const EdgeInsets.all(12),
                  //       margin: const EdgeInsets.only(
                  //         bottom: 10,
                  //       ),
                  //       decoration: BoxDecoration(
                  //           color: Colors.grey.withOpacity(0.2),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(10))),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Chez moi , pharmacie Dan gao',
                  //             style: GoogleFonts.acme(
                  //                 fontSize: 17,
                  //                 color: Colors.black.withOpacity(0.8)),
                  //           ),
                  //           const Icon(Icons.mode_edit_outline_outlined)
                  //         ],
                  //       )),
                  // ),
                  // Text(
                  //   'Coupon',
                  //   style: GoogleFonts.acme(fontSize: 17),
                  // ),
                  // Container(
                  //     margin: const EdgeInsets.only(
                  //       bottom: 10,
                  //     ),
                  //     // height: 40,
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey.withOpacity(0.2),
                  //         borderRadius:
                  //             const BorderRadius.all(Radius.circular(10))),
                  //     child: Form(
                  //       // key: _form,
                  //       child: TextFormField(
                  //         focusNode: _focusNode,
                  //         // validator: ValidationBuilder().required().build(),
                  //         controller: authController.email,
                  //         keyboardType: TextInputType.emailAddress,
                  //         decoration: InputDecoration(
                  //             hintStyle: GoogleFonts.acme(fontSize: 17),
                  //             hintText: '*****',
                  //             contentPadding:
                  //                 const EdgeInsets.symmetric(horizontal: 10),
                  //             border: InputBorder.none),
                  //       ),
                  //     )),

                  // Text(
                  //   'Contenu du panier',
                  //   style: GoogleFonts.acme(fontSize: 17),
                  // ),
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
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            title: Text(
              'Total : ',
              style:
                  GoogleFonts.acme(fontSize: 18, fontWeight: FontWeight.bold),
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
              child: Text('Suivant',
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }
}
