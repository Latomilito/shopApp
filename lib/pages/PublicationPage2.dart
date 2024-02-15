import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/pages/AjouterCategoriePage.dart';
import 'package:shopapp/pages/PageAjouterProduit.dart';
import 'package:shopapp/pages/watsapCamera.dart';
import 'package:whatsapp_camera/camera/view_image.dart';

class PublicationPage2 extends StatefulWidget {
  const PublicationPage2({super.key});

  @override
  State<PublicationPage2> createState() => _PublicationPage2State();
}

class _PublicationPage2State extends State<PublicationPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tableau de bord',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              optionwidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const WhatsappPage();
                    },
                  ));
                },
                icon: Icons.article_outlined,
                text: 'Ajouter au un produit',
                color: Colors.red,
              ),
              optionwidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const AddCategoryPage();
                    },
                  ));
                },
                icon: Icons.category,
                text: 'Mes Collections',
                color: Colors.red,
              ),
              optionwidget(
                icon: Icons.list_alt_outlined,
                text: 'Gerer mon catalogue',
                color: Colors.yellow,
              ),
              optionwidget(
                icon: Icons.newspaper_sharp,
                text: 'Faire une annonce',
                color: Colors.green,
              ),
              optionwidget(
                icon: Icons.local_offer_outlined,
                text: 'Promouvoir un produit',
                color: Colors.orange,
              ),
              optionwidget(
                icon: Icons.newspaper_outlined,
                text: 'Faire une annonce',
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class optionwidget extends StatelessWidget {
  optionwidget(
      {super.key,
      required this.icon,
      required this.text,
      this.onPressed,
      required,
      required this.color});
  IconData icon;
  String text;
  void Function()? onPressed;
  Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.3),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ));
  }
}
