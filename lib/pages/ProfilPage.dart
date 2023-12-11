import 'package:flutter/material.dart';
import 'package:shopapp/controllers.dart/appController.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String email = authController.usermodel.value.email!;
  String name = authController.usermodel.value.nom!;

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/americain.jpg'), // Remplacez par le chemin de votre image de profil
            ),
            const SizedBox(height: 16),
            _isEditing
                ? Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nom'),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration:
                            const InputDecoration(labelText: 'Adresse E-mail'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Mettez à jour les informations de l'utilisateur avec les valeurs des contrôleurs.
                          setState(() {
                            name = _nameController.text;
                            email = _emailController.text;
                            _isEditing = false;
                          });
                        },
                        child: const Text('Enregistrer'),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                authController.singOut();
              },
              child: const Text('Déconnexion'),
            ),
          ],
        ),
      ),
    );
  }
}
