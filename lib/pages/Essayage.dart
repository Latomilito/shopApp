import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';

class Essayge extends StatefulWidget {
  const Essayge({super.key});

  @override
  State<Essayge> createState() => _EssaygeState();
}

class _EssaygeState extends State<Essayge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              4,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                // color: Colors.grey.withOpacity(0.5),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // height: ,
                      child: const Row(children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'assets/americain.jpg'), // Remplacez par le chemin de votre image de profil
                        ),
                      ]),
                    ),
                    Expanded(
                        child: Image.asset(
                      'assets/pub.jpg',
                      width: double.infinity,
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      // height: 60,
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                                // size: 35,
                              ),
                              Icon(
                                Icons.mode_comment_outlined,
                                color: Colors.grey,
                                // size: 35,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                                'Découvrez tous les bons plans et les réductions\n sur les smartphones de Samsung'),
                          )
                        ],
                      ),
                      // color: Colors.black,
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
