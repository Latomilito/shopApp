import 'package:flutter/material.dart';
import 'package:shopapp/pages/CategoriPag.dart';
import 'package:shopapp/pages/hommPage.dart';

import 'allCategories.dart';
import 'commandeInfo.dart';
import 'historiquePage.dart';
import 'home2.dart';
import 'outilsPage.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _selectedIndex = 0;
  // final List<Produit> listeProduits = [
  //   Produit(
  //     nom: 'Produit 1',
  //     description: 'Description du produit 1...',
  //     prix: 19.99,
  //     quantiteEnStock: 30,
  //     image: 'https://exemple.com/image-produit-1.jpg',
  //     imagesSupplementaires: [
  //       'https://exemple.com/image-1-1.jpg',
  //       'https://exemple.com/image-1-2.jpg',
  //     ],
  //     avisClients: 'Avis des clients pour le produit 1...',
  //     informationsContactVendeur: 'Contact du vendeur pour le produit 1...',
  //   ),
  //   Produit(
  //     nom: 'Produit 2',
  //     description: 'Description du produit 2...',
  //     prix: 24.99,
  //     quantiteEnStock: 20,
  //     image: 'https://exemple.com/image-produit-2.jpg',
  //     imagesSupplementaires: [
  //       'https://exemple.com/image-2-1.jpg',
  //       'https://exemple.com/image-2-2.jpg',
  //     ],
  //     avisClients: 'Avis des clients pour le produit 2...',
  //     informationsContactVendeur: 'Contact du vendeur pour le produit 2...',
  //   ),
  //   Produit(
  //     nom: 'Produit 3',
  //     description: 'Description du produit 3...',
  //     prix: 12.99,
  //     quantiteEnStock: 15,
  //     image: 'https://exemple.com/image-produit-3.jpg',
  //     imagesSupplementaires: [
  //       'https://exemple.com/image-3-1.jpg',
  //       'https://exemple.com/image-3-2.jpg',
  //     ],
  //     avisClients: 'Avis des clients pour le produit 3...',
  //     informationsContactVendeur: 'Contact du vendeur pour le produit 3...',
  //   ),
  //   // Ajoutez plus de produits ici
  //   // Par exemple :
  //   Produit(
  //     nom: 'Produit 4',
  //     description: 'Description du produit 4...',
  //     prix: 49.99,
  //     quantiteEnStock: 10,
  //     image: 'https://exemple.com/image-produit-4.jpg',
  //     imagesSupplementaires: [
  //       'https://exemple.com/image-4-1.jpg',
  //       'https://exemple.com/image-4-2.jpg',
  //     ],
  //     avisClients: 'Avis des clients pour le produit 4...',
  //     informationsContactVendeur: 'Contact du vendeur pour le produit 4...',
  //   ),
  //   // Et ainsi de suite...
  // ];
  final List<Widget> _pages = [
    // HomePage(),

    const Home5(),
    CategoryPage(),
    // CategoryPage(),
    // const AllcategoriesPage(),
    // PagePanier(),
    CommandeInfoPage(),
    // const FavoritePage(),
    HistoriquePage(),
    ToolPage()
    // ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        fixedColor: Colors.orange, unselectedItemColor: Colors.grey,
        // backgroundColor: Colors.blueAccent,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            // backgroundColor: Colors.orange,
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Récherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
