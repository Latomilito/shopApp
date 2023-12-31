import 'package:flutter/material.dart';
import 'package:shopapp/pages/RecherchePage.dart';
import 'package:shopapp/pages/AcceuilPage.dart';
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
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const AcceuilPage(),
      RecherchePage(),
      CommandeInfoPage(),
      HistoriquePage(),
      const ToolPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.red,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
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
