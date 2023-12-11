import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VotrePage extends StatefulWidget {
  final List<String> images;
  String? title;
  List<String> selectedImages = [];

  VotrePage({required this.images, this.title});

  @override
  _VotrePageState createState() => _VotrePageState();
}

class _VotrePageState extends State<VotrePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<bool> _isSelectedList = List.filled(0, false);

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    // Initialiser la liste avec la taille de votre liste d'images
    _isSelectedList = List.filled(widget.images.length, false);
  }

  List<String> getSelectedImages() {
    List<String> selectedImages = [];
    for (int i = 0; i < widget.images.length; i++) {
      if (_isSelectedList[i]) {
        selectedImages.add(widget.images[i]);
      }
    }
    return selectedImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title!,
          style: const TextStyle(
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Ajoutez votre logique pour afficher l'image en plein écran ici
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: widget.images[index],
                        fit: BoxFit.fill,
                      ),
                      _currentPage == index
                          ? Positioned(
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSelectedList[index] =
                                        !_isSelectedList[index];
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    color: Colors.black,
                                    child: Checkbox(
                                      side: const BorderSide(
                                        color: Colors.white,
                                      ),
                                      focusColor: Colors.orange,
                                      activeColor: Colors.white,
                                      checkColor: Colors.orange,
                                      value: _isSelectedList[index],
                                      onChanged: (value) {
                                        setState(() {
                                          _isSelectedList[index] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.extent(
                maxCrossAxisExtent: 80,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: List.generate(
                  widget.images.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(index);
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentPage == index
                                ? Colors.orange
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              width: 80,
                              imageUrl: widget.images[index],
                              fit: BoxFit.fill,
                            ),
                            _isSelectedList[index]
                                ? Positioned(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isSelectedList[index] =
                                              !_isSelectedList[index];
                                        });
                                      },
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        color: Colors.grey.withOpacity(0.7),
                                        child: Checkbox(
                                          side: const BorderSide(
                                            color: Colors.orange,
                                          ),
                                          focusColor: Colors.orange,
                                          activeColor: Colors.white,
                                          checkColor: Colors.orange,
                                          value: _isSelectedList[index],
                                          onChanged: (value) {
                                            setState(() {
                                              _isSelectedList[index] = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
