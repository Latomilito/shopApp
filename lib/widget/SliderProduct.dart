import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/models/productModels.dart';

class SliderProduct extends StatefulWidget {
  final Produit? produit;
  String? urlImage;

  SliderProduct({Key? key, this.produit, this.urlImage}) : super(key: key);

  @override
  State<SliderProduct> createState() => _SliderProductState();
}

class _SliderProductState extends State<SliderProduct> {
  final PageController _pageController = PageController();
  bool isselected = false;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   if (_currentPage <
    //       widget.produit.images!
    //               .where((element) => element != '')
    //               .toList()
    //               .length -
    //           1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.6,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: double.maxFinite,
                      imageUrl: widget.urlImage!,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.withOpacity(0.2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Card(
                              color: Colors.orange,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 5, top: 5, left: 8),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Card(
                            color: Colors.orange,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                                left: 5,
                                right: 5,
                                top: 5,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  )
                  // Expanded(
                  //   child: Stack(
                  //     children: [
                  //       widget.produit.images!.length != 1
                  //           ? PageView.builder(
                  //               controller: _pageController,
                  //               onPageChanged: (page) {
                  //                 setState(() {
                  //                   _currentPage = page;
                  //                 });
                  //               },
                  //               itemCount: widget.produit.images!
                  //                   .where((element) => element != '')
                  //                   .toList()
                  //                   .length,
                  //               itemBuilder: (buildContext, index) {
                  //                 return CachedNetworkImage(
                  //                   imageUrl: widget.produit.images![index],
                  //                   fit: BoxFit.fill,
                  //                   errorWidget: (context, url, error) => Container(
                  //                     color: Colors.grey.withOpacity(0.2),
                  //                     child: const Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         SizedBox(
                  //                             height: 20,
                  //                             width: 20,
                  //                             child: CircularProgressIndicator(
                  //                               color: Colors.orange,
                  //                             )),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //             )
                  //           : CachedNetworkImage(
                  //               imageUrl: widget.produit.images![0],
                  //               fit: BoxFit.fill,
                  //               width: double.infinity,
                  //             ),
                  //       Column(
                  //         children: [
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           Row(
                  //             children: [
                  //               IconButton(
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                   icon: const Icon(Icons.arrow_back_ios))
                  //             ],
                  //           ),
                  //           const Spacer(),
                  //           widget.produit.images!.length != 1
                  //               ? Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: List.generate(
                  //                     widget.produit.images!
                  //                         .where((element) => element != '')
                  //                         .toList()
                  //                         .length,
                  //                     (index) => Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: CircleAvatar(
                  //                         backgroundColor: _currentPage == index
                  //                             ? Colors.orange
                  //                             : Colors.grey,
                  //                         maxRadius: 5,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox()
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ])),
    );
  }
}
