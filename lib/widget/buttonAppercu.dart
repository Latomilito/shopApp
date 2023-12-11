import 'package:flutter/material.dart';

class BoutonApercuProduit extends StatelessWidget {
  final VoidCallback onPressed;

  const BoutonApercuProduit({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Aperçu'),
    );
  }
}
