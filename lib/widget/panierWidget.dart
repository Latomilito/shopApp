import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/CartItemModel.dart';

class panierWidget extends StatefulWidget {
  CartItemModel? cartitem;

  int? quantite;

  panierWidget({super.key, this.cartitem, required this.quantite});

  @override
  State<panierWidget> createState() => _ApercuPanierState();
}

class _ApercuPanierState extends State<panierWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0),
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
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      Text(
                        '${widget.cartitem!.price!.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${widget.cartitem!.price!.toStringAsFixed(0)}x${widget.cartitem!.quantity.toStringAsFixed(0)} = ${(widget.cartitem!.price! * widget.cartitem!.quantity).toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Card(
                        elevation: 0,
                        // color: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          child: Text(
                            'Sana\'s market',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              color: Colors.black,
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
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
