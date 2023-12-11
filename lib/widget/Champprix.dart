import 'package:flutter/material.dart';

class ChampPrixProduit extends StatefulWidget {
  String? prixControllerCategorie;
  final TextEditingController? controller;
  bool? isMEme;
  final String? Function(String?)? validator;
  final String? Function(String?)? prixMeme;

  ChampPrixProduit(
      {this.controller,
      this.validator,
      this.prixControllerCategorie,
      required this.isMEme,
      this.prixMeme});

  @override
  State<ChampPrixProduit> createState() => _ChampPrixProduitState();
}

class _ChampPrixProduitState extends State<ChampPrixProduit> {
  bool _isMemePrixSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.prixControllerCategorie != null) {
      widget.controller!.text = widget.prixControllerCategorie!;
      // widget.prixMeme!(widget.prixControllerCategorie);
    }
    return widget.isMEme!
        ? TextFormField(
            onChanged: (value) {
              setState(() {
                widget.prixMeme!(value);
              });
            },
            style: const TextStyle(color: Colors.green),
            controller: widget.controller,
            keyboardType:
                TextInputType.number, // Clavier numérique pour les prix
            decoration: InputDecoration(
              labelText:
                  _isMemePrixSelected ? 'Prix des Produits' : 'Prix du Produit',
              hintText: 'Entrez le prix du produit',
              border: const OutlineInputBorder(),
            ),
            validator: widget.validator,
          )
        : Column(
            children: [
              if (_isMemePrixSelected)
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      widget.prixMeme!(value);
                    });
                  },
                  style: const TextStyle(color: Colors.green),
                  controller: widget.controller,
                  keyboardType:
                      TextInputType.number, // Clavier numérique pour les prix
                  decoration: InputDecoration(
                    labelText: _isMemePrixSelected
                        ? 'Prix des Produits'
                        : 'Prix du Produit',
                    hintText: 'Entrez le prix du produit',
                    border: const OutlineInputBorder(),
                  ),
                  validator: widget.validator,
                ),
              if (!_isMemePrixSelected)
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isMemePrixSelected = true;
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('même prix ?'),
                    ],
                  ),
                ),
            ],
          );
  }
}
