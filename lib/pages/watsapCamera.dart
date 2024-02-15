import 'dart:io';

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

class WhatsappPage extends StatefulWidget {
  const WhatsappPage({Key? key});

  @override
  State<WhatsappPage> createState() => _WhatsappPageState();
}

class _WhatsappPageState extends State<WhatsappPage> {
  FocusNode _focusNode = FocusNode();
  final ValueNotifier<List<File>> files = ValueNotifier<List<File>>([]);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  String _selectedCategory =
      ''; // Ajout du state pour la catégorie sélectionnée
  Set<String> categoriesSet = repositoryController.allproduits
      .map((element) => element.categorie!)
      .toSet();

  @override
  void dispose() {
    files.dispose();
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un produit"),
        actions: [
          IconButton(
              onPressed: () async {
                List<File>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WhatsappCamera(),
                  ),
                );
                if (result != null) {
                  files.value = result;
                  setState(() {});
                  _pageController
                      .jumpToPage(0); // Scroll back to the first image
                }
              },
              icon: const Icon(Icons.camera))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: files.value.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 2,
                        color: _currentPageIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.file(
                        files.value[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: files.value.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.file(
                      files.value[index],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: nameController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        hintText: 'Nom',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: priceController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        hintText: 'Prix',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: descriptionController,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Description',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FindDropdown(
                                dropdownBuilder: (context, selectedItem) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      children: [
                                        Text(
                                          selectedItem!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                searchBoxDecoration: const InputDecoration(
                                    hintText: 'Saisir',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                emptyBuilder: (context) {
                                  return Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        child:
                                            const Text('Ajouter une catégorie'),
                                      ),
                                    ],
                                  );
                                },
                                dropdownItemBuilder:
                                    (context, item, isSelected) {
                                  return ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.highlight_remove_outlined)),
                                  );
                                },
                                items: categoriesSet.toList(),
                                onChanged: (value) {},
                                selectedItem: categoriesSet.toList().first,
                              )
                              // DropdownButton pour la catégorie
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
