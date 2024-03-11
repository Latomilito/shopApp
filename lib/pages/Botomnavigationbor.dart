import 'package:flutter/material.dart';
import 'package:shopapp/pages/RecherchePage.dart';
import 'package:shopapp/pages/AcceuilPage.dart';
import 'package:shopapp/pages/favoritePage.dart';
import 'commandeInfo.dart';
import 'historiquePage.dart';
import 'outilsPage.dart';

class BottomnavigationPage extends StatefulWidget {
  const BottomnavigationPage({Key? key}) : super(key: key);

  @override
  _BottomnavigationPageState createState() => _BottomnavigationPageState();
}

class _BottomnavigationPageState extends State<BottomnavigationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const AcceuilPage(),
      const FavoritePage(),
      CommandeInfoPage(),
      HistoriquePage(),
      const ToolPage()
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      // body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.red,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
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
