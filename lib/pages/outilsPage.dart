import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/pages/Dashbord.dart';

import 'ProfilPage.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Page d\'outils',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: const Text('Sécurité'),
              onTap: () {},
            ),
            authController.usermodel.value.email != 'taylorhak@gmail.com'
                ? ListTile(
                    leading: const Icon(Icons.dashboard_outlined),
                    title: const Text('Tableau de bord'),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext conta) {
                        return DashboardPage();
                      }));
                    },
                  )
                : Container(),
            // Ajoutez d'autres options selon vos besoins
          ],
        ),
      ),
    );
  }
}
