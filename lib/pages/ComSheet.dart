import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:get/get.dart';
import 'package:shopapp/models/productModels.dart';

import '../controllers.dart/appController.dart';
import '../utility/Utility.dart';
import 'BoutiquePage.dart';

class CommentBottomSheet extends StatefulWidget {
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}

void showProductBottomSheet(BuildContext context) {
  showModalBottomSheet(
    // backgroundColor: Colors.black.withOpacity(0.9),
    showDragHandle: true,

    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) {
      return SafeArea(child: CommentBottomSheet());
    },

    isScrollControlled:
        false, // Permet le défilement si la hauteur dépasse l'écran
  );
}
