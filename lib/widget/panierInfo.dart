// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';

import '../models/productModels.dart';
import 'package:shopapp/models/CartItemModel.dart';
// import '../Productmodels.dart';

class panierInfo extends StatefulWidget {
  final CartItemModel cartitem;

  final int quantite;

  const panierInfo({super.key, required this.cartitem, required this.quantite});

  @override
  State<panierInfo> createState() => _panierInfoState();
}

class _panierInfoState extends State<panierInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     borderRadius: const BorderRadius.all(Radius.circular(10)),
      //     border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4))),
      child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: widget.cartitem.image!,
            height: 100,
          ),
          title: Text(widget.cartitem.name!),
          subtitle: Text(widget.cartitem.price!.toStringAsFixed(0)),
          trailing: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: TextFormField(
                style: const TextStyle(fontSize: 30),
                decoration: const InputDecoration(border: InputBorder.none),
              ))),
    );
  }
}
