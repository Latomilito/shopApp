import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/pages/Dashbord.dart';
import 'package:shopapp/pages/Essayage.dart';
import 'package:shopapp/pages/ProfilPage.dart';

class ToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'outils'),
      ),
      body: ListView(
        children: <Widget>[
          // Profil de l'utilisateur
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext conta) {
                return ProfilePage();
              }));
            },
          ),

          // Autres options
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext conta) {
                return const Essayge();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: const Text('Sécurité'),
            onTap: () {
              // Ajoutez ici la logique pour naviguer vers la page de sécurité
            },
          ),
          authController.usermodel.value.email == 'taylorhak@gmail.com'
              ? ListTile(
                  leading: const Icon(Icons.dashboard_outlined),
                  title: const Text('Tableau de bord'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext conta) {
                      return DashboardPage();
                    }));
                  },
                )
              : Container(),
          // Ajoutez d'autres options selon vos besoins
        ],
      ),
    );
  }
}
