import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/models/productModels.dart';

class SliderPromotion extends StatefulWidget {
  List<String> images;

  SliderPromotion({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<SliderPromotion> createState() => _SliderProductState();
}

class _SliderProductState extends State<SliderPromotion> {
  final PageController _pageController = PageController();
  bool isselected = false;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                widget.images.length != 1
                    ? PageView.builder(
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemCount: widget.images.length,
                        itemBuilder: (buildContext, index) {
                          // return CachedNetworkImage(
                          //   imageUrl: widget.images[index],
                          //   fit: BoxFit.fill,
                          // );
                          return Image.asset(
                            widget.images[index],
                            fit: BoxFit.fill,
                          );
                        },
                      )
                    : Image.asset(
                        widget.images[0],
                        fit: BoxFit.fill,
                      ),
                // : CachedNetworkImage(
                //     imageUrl: widget.images[0],
                //     fit: BoxFit.fill,
                //     width: double.infinity,
                //   ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Spacer(),
                    widget.images.length != 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.images.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundColor: _currentPage == index
                                      ? Colors.orange
                                      : Colors.grey,
                                  maxRadius: 5,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
