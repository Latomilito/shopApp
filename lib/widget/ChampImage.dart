import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChampImageProduit extends StatefulWidget {
  List<String>? images;
  final void Function(List<File?>)
      onImagesSelected; // Callback pour renvoyer les images

  ChampImageProduit({super.key, required this.onImagesSelected, this.images});

  @override
  // ignore: library_private_types_in_public_api
  _ChampImageProduitState createState() => _ChampImageProduitState();
}

class _ChampImageProduitState extends State<ChampImageProduit> {
  List<File?> selectedImages = [null, null, null, null];

  Future pikedImage(int index) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file1 = File(pickedFile!.path);

    setState(() {
      selectedImages[index] = file1;
    });

    // Renvoyez les images sélectionnées à la page parente
    widget.onImagesSelected(selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 3; i++)
              GestureDetector(
                onTap: () {
                  pikedImage(i);
                },
                child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: widget.images!.isEmpty
                        ? selectedImages[i] != null
                            ? Image.file(
                                selectedImages[i]!,
                                height: 100,
                                fit: BoxFit.fill,
                              )
                            : Center(
                                child: Text('${i + 1}'),
                              )
                        : selectedImages[i] != null
                            ? Image.file(
                                selectedImages[i]!,
                                height: 100,
                                fit: BoxFit.fill,
                              )
                            : widget.images![i] != ''
                                ? CachedNetworkImage(
                                    imageUrl: widget.images![i],
                                    height: 100,
                                  )
                                : Center(
                                    child: Text('${i + 1}'),
                                  )),
              ),
          ],
        ),
      ],
    );
  }
}
