import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/authentification/registerPage.dart';

import '../controllers.dart/appController.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
                      controller: authController.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Email',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  // height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    // key: _form,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      // validator: ValidationBuilder().required().build(),
                      controller: authController.password,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.acme(fontSize: 17),
                          hintText: 'Mot de passe',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () async {
                    await authController.logIn(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Se connecter',
                        style:
                            GoogleFonts.acme(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Get.off(() => const RegisterPage());
                },
                child: Text(
                  'nouveau compte ?',
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
