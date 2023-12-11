import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/StandarPublication.dart';
import 'package:shopapp/widget/buildCategoryGrid.dart';
import 'package:story_view/story_view.dart';

import '../models/productModels.dart';
import '../utility/Utility.dart';
import 'ComSheet.dart';
import 'home2.dart';

class StoryViewDemo extends StatefulWidget {
  List<Produit>? produit;
  List<PublicationStandard>? publications;
  StoryViewDemo({super.key, this.produit, this.publications});

  @override
  State<StoryViewDemo> createState() => _StoryViewDemoState();
}

class _StoryViewDemoState extends State<StoryViewDemo> {
  final storyController = StoryController();
  int? index1;
  Produit? produit;
  Iterable<StoryItem> storie = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storie = widget.produit!.map((produitt) {
      index1 = widget.produit!.indexOf(produitt);
      PublicationStandard publication = widget.publications!.firstWhere(
          (element) =>
              element.productIds!.contains(widget.produit![index1!].id));
      produit = widget.produit![index1!];
      return StoryItem(
        SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   leading: const SizedBox(),
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            // ),
            backgroundColor: Colors.grey.withOpacity(0.3),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(360)),
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
                            return home();
                          }));
                        },
                        child: const Text(
                          'Sana\'s market',
                          style: TextStyle(color: Colors.orange, fontSize: 15),
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

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            fit: BoxFit.fill,
                            imageUrl: widget.produit![index1!].images!.first),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Text(
                                  widget.produit![index1!].nom == ''
                                      ? widget.produit![index1!].categorie!
                                      : widget.produit![index1!].nom!,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                index1!.toString(),
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            publication.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  const Column(
                    children: [
                      RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.arrow_back_ios_new_rounded)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Tirez'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
      );
    });
  }

  Widget build(BuildContext context) {
    return StoryView(
      onComplete: () {
        Navigator.of(context).pop();
      },
      onVerticalSwipeComplete: (value) {
        storyController.pause();
        value == Direction.up
            ? showProductStoriBottomSheet(context, widget.produit!, index1)
            : null;
      },
      onStoryShow: (storiItem) {},

      indicatorForegroundColor: Colors.orange,
      indicatorColor: Colors.grey,
      storyItems: storie.toList(),
      controller: storyController,
      inline: true, // Set to true if you want inline stories
      repeat: false, // Set to true if you want stories to repeat
    );
  }
}
