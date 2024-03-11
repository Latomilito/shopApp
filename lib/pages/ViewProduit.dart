import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/productModels.dart';

class ViewProduit extends StatefulWidget {
  ViewProduit(
      {super.key,
      this.quantity,
      this.prouit,
      this.pageController,
      this.produits});
  List<Produit>? produits;
  int? quantity;
  Produit? prouit;
  PageController? pageController;
  @override
  State<ViewProduit> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ViewProduit> {
  Produit? produit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    produit = widget.prouit!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Sana\'s market',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            produit = widget.produits![value];
          });
        },
        controller: widget.pageController,
        itemCount: widget.produits!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                      imageUrl: widget.produits![index].images!.first),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
