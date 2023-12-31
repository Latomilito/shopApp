import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopapp/authentification/loginPage.dart';
import 'package:shopapp/controllers.dart/appController.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/models/productModels.dart';
import 'package:shopapp/models/userModel.dart';

import '../models/StandarPublication.dart';
import '../pages/Botomnavigationbor.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseFirestore fierstore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rx<Usermodel> usermodel = Usermodel().obs;
  RxList<Usermodel> userlist = RxList<Usermodel>([]);
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    // singOut();

    firebaseUser = Rxn<User>(auth.currentUser);

    ever(firebaseUser, setInitialScreen);
    // usermodel.bindStream(initialiseUserModel());
    firebaseUser.bindStream(auth.userChanges().cast());
    repositoryController.allproduits
        .bindStream(repositoryController.allproduct());
    repositoryController.allpublications
        .bindStream(repositoryController.allpublication());
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      usermodel.bindStream(initialiseUserModel());
      // await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => const BottomnavigationPage());
    }
  }

  void clear() {
    phone.clear();
    name.clear();
    password.clear();
  }

  _addUserToFirebase(
    String userId,
  ) {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    firestore1.settings = const Settings(persistenceEnabled: true);
    firestore1.collection('users').doc(userId).set({
      'name': name.text.trim(),
      'id': userId,
      'password': password.text.trim(),
      'email': email.text.trim(),
      'phone': phone.text.trim(),
      'favoris': [],
    });
  }

  Future sinUp(BuildContext context) async {
    try {
      Get.defaultDialog(
          title: 'chargement..',
          content: const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ));
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        String userId = value.user!.uid;
        _addUserToFirebase(userId);
        clear();
      }).whenComplete(() => usermodel.bindStream(initialiseUserModel()));
    } catch (e) {
      // Get.snackbar('Inscription  échouée', 'Ressayer à nouveau');
      debugPrint(e.toString());
      Get.back();
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Erreur',
        desc: "Une erreur s\'est Produite",
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
  }

  Future singOut() async {
    try {
      clear();
      await auth.signOut().whenComplete(() {});
    } catch (e) {
      Get.snackbar('Déconnection', '');
    }
  }

  Stream<Usermodel> initialiseUserModel() {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    firestore1.settings = const Settings(persistenceEnabled: true);
    return firestore1
        .collection('users')
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => Usermodel.fromsnapshot(snapshot));
  }

  Future logIn(BuildContext context) async {
    try {
      Get.defaultDialog(
          title: 'chargement..',
          content: const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(color: Colors.orange),
          ));
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        debugPrint('User added');
        // clear();
        return true;
      }).whenComplete(() => usermodel.bindStream(initialiseUserModel()));
    } catch (e) {
      debugPrint(e.toString());
      print(e);
      Get.back();
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Erreur',
        desc: "Une erreur s\'est Produite",
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
      // Utilities().internetException(e, context);
    }
  }

  updateUserData(Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.value!.uid)
        .update(data);
  }
}
