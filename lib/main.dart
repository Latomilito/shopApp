import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers.dart/CartController.dart';
import 'controllers.dart/AuthController.dart';
import 'controllers.dart/RepositoryConroller.dart';
import 'firebase_options.dart';

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
          iconButtonTheme: const IconButtonThemeData(
              style:
                  ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.red))),
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.red),
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.red)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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
