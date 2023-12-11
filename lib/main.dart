import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/controllers.dart/CartController.dart';
import 'package:shopapp/pages/Cartpage.dart';
import 'package:shopapp/pages/NotificationPage.dart';
import 'package:shopapp/pages/ProdicPromoPage.dart';
import 'package:shopapp/pages/ProducDetails.dart';
import 'package:shopapp/pages/ProfilPage.dart';
import 'package:shopapp/pages/allCategories.dart';
import 'package:shopapp/pages/commandeInfo.dart';
import 'package:shopapp/pages/historiquePage.dart';
import 'package:shopapp/pages/homePage.dart';
import 'package:shopapp/pages/outilsPage.dart';
import 'package:shopapp/pages/publication.dart';
import 'package:shopapp/widget/producItem.dart';

import 'controllers.dart/AuthController.dart';
import 'controllers.dart/RepositoryConroller.dart';
import 'controllers.dart/appController.dart';
import 'firebase_options.dart';
import 'models/productModels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(RepositoryController());
    Get.put(CartController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.orange)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          // useMaterial3: true,
        ),
        home: const Myhomepage()
        // home: home(),
        );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(),
    );
  }
}
