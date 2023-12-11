import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/models/Promotion.dart';
import 'package:uuid/uuid.dart';

class AjouterPromotionPage extends StatefulWidget {
  @override
  _AjouterPromotionPageState createState() => _AjouterPromotionPageState();
}

class _AjouterPromotionPageState extends State<AjouterPromotionPage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController pourcentageController = TextEditingController();
  List<File?> images = [null];
  String? imageUrls;

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('promotion_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une promotion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: titreController,
              decoration: InputDecoration(labelText: 'Titre de la promotion'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration:
                  InputDecoration(labelText: 'Description de la promotion'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: pourcentageController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Pourcentage de réduction'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un pourcentage';
                }
                if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () async {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  final downloadUrl = await uploadImageToFirebaseStorage(
                      File(pickedImage.path));
                  setState(() {
                    imageUrls = downloadUrl;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ajouter une image',
                    style: GoogleFonts.acme(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ),
            if (imageUrls != null) Image.network(imageUrls!),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                // final promotion = Promotion(
                //   titre: titreController.text.trim(),
                //   : descriptionController.text.trim(),
                //   discountPercentage: double.parse(pourcentageController.text),
                //   image: imageUrls,
                // );
                // Enregistrez la promotion ou effectuez d'autres opérations nécessaires
                // print(promotion.toMap());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ajouter la promotion',
                    style: GoogleFonts.acme(fontSize: 17, color: Colors.white),
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
