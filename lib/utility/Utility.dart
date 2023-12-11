import 'dart:io';
// import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Utilities {
  static String getDayName(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return "Lundi";
      case 2:
        return "Mardi";
      case 3:
        return "Mercredi";
      case 4:
        return "Jeudi";
      case 5:
        return "Vendredi";
      case 6:
        return "Samedi";
      case 7:
        return "Dimanche";
      default:
        return "Jour non valide";
    }
  }

  static String getMonthName(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return "Jan";
      case 2:
        return "Fév";
      case 3:
        return "Mar";
      case 4:
        return "Avr";
      case 5:
        return "Mai";
      case 6:
        return "Juin";
      case 7:
        return "Juil";
      case 8:
        return "Août";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Déc";

      default:
        return "Mois non valide";
    }
  }

  void interneterrorMessage(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Erreur",
      desc: "Vérifier votre connexion internet",
      buttons: [
        DialogButton(
          onPressed: () => Get.back(),
          color: Colors.red,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void errorMessage(BuildContext context) {
    Get.back();
    Alert(
      context: context,
      type: AlertType.error,
      title: "Erreur",
      desc: "Une erreur s'est produite",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.orange,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void internetException(Object e, BuildContext context) {
    if (e is PlatformException) {
      print(e);

      Utilities().interneterrorMessage(context);
      return;
    } else {
      // ignore: use_build_context_synchronously
      Utilities().errorMessage(context);
      return;
    }
  }

  void errorMessageFirebase(Object e, BuildContext context) {
    if (e is HttpException) {
      print(e);

      Utilities().interneterrorMessage(context);
      return;
    } else {
      // ignore: use_build_context_synchronously
      Utilities().errorMessage(context);
      return;
    }
  }

//   Future<void> demanderPermissionContacts() async {
//     final PermissionStatus status = await Permission.contacts.request();

//     if (status.isGranted) {
//       // Get.offAll(() => ContactsPage());
//     } else {}
//   }

//   Future<void> demanderPermissionLocalisation() async {
//     final PermissionStatus status = await Permission.location.request();

//     if (status.isGranted) {
//       // L'autorisation d'accéder à la localisation a été accordée
//     } else {
//       // L'utilisateur a refusé l'autorisation d'accéder à la localisation
//     }
//   }
// }

// class optionWidget extends StatelessWidget {
//   optionWidget({
//     this.icon,
//     this.text,
//     this.onPressed,
//     super.key,
//   });
//   IconData? icon;
//   String? text;
//   final VoidCallback? onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialogOption(
//       onPressed: onPressed,
//       child: Text(text!),
//     );
//   }
// }
}
