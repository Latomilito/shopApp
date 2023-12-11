// import 'package:flutter/material.dart';
// // import 'package:your_app/models/adresse.dart';

// class AdressesPage extends StatelessWidget {
//   // final List<Adresse> adresses; // Liste des adresses de l'utilisateur

//   AdressesPage({required this.adresses});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mes Adresses'),
//       ),
//       body: ListView.builder(
//         itemCount: adresses.length,
//         itemBuilder: (context, index) {
//           final adresse = adresses[index];
//           return ListTile(
//             title: Text(adresse.nom),
//             subtitle: Text('${adresse.adresse}, ${adresse.ville} ${adresse.codePostal}'),
//             trailing: IconButton(
//               icon: Icon(Icons.edit),
//               onPressed: () {
//                 // Naviguez vers une page d'édition pour cette adresse
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => EditAdressePage(adresse: adresse),
//                 ));
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Naviguez vers une page pour ajouter une nouvelle adresse
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => AddAdressePage(),
//           ));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
