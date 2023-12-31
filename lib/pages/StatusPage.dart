import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/pages/producDetails2.dart';
import '../controllers.dart/appController.dart';
import '../models/StandarPublication.dart';
import '../models/productModels.dart';
import '../utility/Utility.dart';
import 'ComSheet.dart';
import 'BoutiquePage.dart';

class StatusPage extends StatefulWidget {
  PageController? pageController;
  List<Produit>? produit;
  bool? isStory;
  int? index1;
  List<PublicationStandard>? publications;
  StatusPage(
      {super.key,
      this.produit,
      this.publications,
      this.isStory,
      this.index1,
      this.pageController});

  @override
  State<StatusPage> createState() => _HistorieState();
}

class _HistorieState extends State<StatusPage> {
  int selectedindex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedindex = widget.index1!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  selectedindex = value;
                });
              },
              controller: widget.pageController,
              itemCount: widget.produit!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (buildContext, index) {
                PublicationStandard publication = widget.publications!
                    .firstWhere((element) => element.productIds!
                        .contains(widget.produit![index].id));
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: List.generate(
                                widget.produit!.length,
                                (index) => Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    height: 4,
                                    // width: 1,
                                    decoration: BoxDecoration(
                                        color: selectedindex == index
                                            ? Colors.orange
                                            : Colors.grey,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(360)),
                                child: CachedNetworkImage(
                                    height: 30,
                                    width: 30,
                                    imageUrl: repositoryController
                                        .allproduits.first.images!.first),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return BoutiquePage();
                                  }));
                                },
                                child: const Text(
                                  'Sana\'s market',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 15),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${Utilities.getDayName(publication.date!.weekday)} le ${publication.date!.day} ${Utilities.getMonthName(publication.date!.month)} à ${publication.date!.hour}h ${publication.date!.minute}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: widget.isStory!
                                          ? MediaQuery.of(context).size.height /
                                              2
                                          : MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                              width: double.infinity,
                                              height: widget.isStory!
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                              fit: BoxFit.cover,
                                              imageUrl: widget.produit![index]
                                                  .images!.first),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        index != 0
                                                            ? widget
                                                                .pageController!
                                                                .jumpToPage(
                                                                    index - 1)
                                                            : null;
                                                      },
                                                      child: Container(
                                                        color: Colors.black
                                                            .withOpacity(0),
                                                      ))),
                                              Expanded(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        index !=
                                                                widget.produit!
                                                                        .length -
                                                                    1
                                                            ? widget
                                                                .pageController!
                                                                .jumpToPage(
                                                                    index + 1)
                                                            : Navigator.of(
                                                                    context)
                                                                .pop();
                                                      },
                                                      child: Container(
                                                        color: Colors.red
                                                            .withOpacity(0),
                                                      ))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.produit![index].nom == ''
                                                    ? widget.produit![index]
                                                        .categorie!
                                                    : widget
                                                        .produit![index].nom!,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              const Text(
                                                '5000 FCFA',
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                              left: 5,
                                              right: 5,
                                              top: 5,
                                            ),
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.orange,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Description',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Divider(
                                          color: Colors.orange,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        publication.description!,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                      ),
                                    ),
                                    if (!widget.isStory!)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Produits similaires',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return DetailsPage2();
                                                  }));
                                                },
                                                child: const Text('voir plus'),
                                              )
                                            ],
                                          ),
                                          const Divider(
                                            height: 1,
                                            color: Colors.orange,
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              // if (!widget.isStory!)
                              SizedBox(
                                // height: 100,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: repositoryController.allproduits
                                        .where((elemet) =>
                                            elemet.categorie ==
                                                widget.produit![index]
                                                    .categorie &&
                                            elemet.id !=
                                                widget.produit![index].id)
                                        .map((element) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return DetailsPage2(
                                                      isFromCategorie: false,
                                                      produit: element,
                                                      // publication: publication,
                                                    );
                                                  }));
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      '6000 FCFA',
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    CachedNetworkImage(
                                                      height: 90,
                                                      width: 90,
                                                      imageUrl:
                                                          element.images!.first,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
                          )))
                        ]));
              })),
    );
  }
}
