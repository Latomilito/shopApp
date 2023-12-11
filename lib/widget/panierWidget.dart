// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';

import '../models/productModels.dart';
import 'package:shopapp/models/CartItemModel.dart';
// import '../Productmodels.dart';

class ApercuPanier extends StatefulWidget {
  CartItemModel? cartitem;

  int? quantite;

  ApercuPanier({super.key, this.cartitem, required this.quantite});

  @override
  State<ApercuPanier> createState() => _ApercuPanierState();
}

class _ApercuPanierState extends State<ApercuPanier> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withOpacity(0.6),

      elevation: 0,
      // margin: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     borderRadius: const BorderRadius.all(Radius.circular(10)),
      //     border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5, right: 10, left: 5),
              height: MediaQuery.of(context).size.height / 9.99,
              width: double.infinity,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: 70,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                      imageUrl: widget.cartitem!.image!,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartitem!.name!,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      Text(
                        '${widget.cartitem!.price!.toStringAsFixed(0)}x${widget.cartitem!.quantity.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        '5000 FCFA',
                        style: TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cartController.increaseQuantity(widget.cartitem!);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cartController.decreaseQuantity(widget.cartitem!);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        )
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.delete,
                        //     size: MediaQuery.of(context).size.height * 0.036,
                        //   ),
                        //   onPressed: () {
                        //     cartController.removeCartItem(widget.cartitem!);
                        //   },
                        // ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.delete,
                        //     size: MediaQuery.of(context).size.height * 0.03,
                        //   ),
                        //   onPressed: () {
                        //     cartController.removeCartItem(widget.cartitem!);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const Divider(
            //   color: Colors.orange,
            // ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 10),
            //   child: TextFormField(decoration: InputDecoration(border: i ) ,),
            // )
          ],
        ),
      ),
    );
  }
}
