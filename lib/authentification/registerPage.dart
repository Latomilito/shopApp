import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/authentification/loginPage.dart';

import '../controllers.dart/appController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
} 

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Center(
                    child: Text(
                  'Taylor Business',
                  style: GoogleFonts.acme(fontSize: 30),
                )),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 10),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      // validator: ValidationBuilder().required().build(),
                      controller: authController.name,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Nom',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: authController.email,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.acme(fontSize: 17),
                      hintText: 'Email',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: authController.phone,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.acme(fontSize: 17),
                      hintText: 'télephone',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: authController.password,
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.acme(fontSize: 17),
                        hintText: 'mot de passe',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    authController.sinUp(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Soumettre',
                        style:
                            GoogleFonts.acme(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Get.off(() => const LoginPage());
                },
                child: Text(
                  'J\'ai un compte',
                  style: GoogleFonts.acme(fontSize: 17, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
