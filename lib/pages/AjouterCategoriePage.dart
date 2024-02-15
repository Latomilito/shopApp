import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  File? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('categories/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(
          'Progression du téléchargement: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
    });
    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // XFile? images;
  Future<void> _pickImages() async {
    try {
      XFile? imagepiked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepiked != null) {
        setState(() {
          _selectedImage = File(imagepiked.path);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection des images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter une Collection',
          style: GoogleFonts.acme(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.vibrate();
                  _pickImages();
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      // focusNode: _focusNode,
                      // validator: ValidationBuilder().required().build(),
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Nom de la collection',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      // focusNode: _focusNode,
                      // validator: ValidationBuilder().required().build(),
                      controller: _descriptionController,
                      maxLines: 3,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Description',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.red),
                onPressed: () {
                  HapticFeedback.vibrate();
                },
                child: Text(
                  'Enregistrer',
                  style: GoogleFonts.acme(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
