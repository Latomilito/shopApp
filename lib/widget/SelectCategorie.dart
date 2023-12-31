import 'package:flutter/material.dart';

class SelecteurCategorieProduit extends StatefulWidget {
  final List<String> categories;
  String? categorieselected;
  final Function(String) onSelect;

  SelecteurCategorieProduit({
    super.key,
    required this.categories,
    required this.onSelect,
    this.categorieselected,
  });

  @override
  _SelecteurCategorieProduitState createState() =>
      _SelecteurCategorieProduitState();
}

class _SelecteurCategorieProduitState extends State<SelecteurCategorieProduit> {
  String? _selectedCategory;
  bool _isOtherSelected = false;

  TextEditingController _otherCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.categorieselected != null) {
      _selectedCategory = widget.categorieselected;
    } else {
      // _selectedCategory = widget.categories.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          hint: const Text('Categorie'),
          style: const TextStyle(color: Colors.green),
          value: _selectedCategory,
          onChanged: (value) {
            setState(() {
              if (value == 'Nouvelle categorie') {
                _isOtherSelected = true;
              } else {
                _selectedCategory = value!;
                widget.onSelect(_selectedCategory!);
                _isOtherSelected = false;
              }
            });
          },
          items: [
            ...widget.categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }),
            const DropdownMenuItem<String>(
              value: 'Nouvelle categorie',
              child: Text('Nouvelle categorie'),
            ),
          ],
          decoration: const InputDecoration(
            labelText: 'Catégorie du Produit',
            border: OutlineInputBorder(),
          ),
        ),
        if (_isOtherSelected)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  controller: _otherCategoryController,
                  decoration: const InputDecoration(
                    labelText: 'Nouvelle Catégorie',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Vous pouvez traiter la nouvelle catégorie ici si nécessaire
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    final newCategory = _otherCategoryController.text;
                    if (newCategory.isNotEmpty) {
                      widget.categories.add(newCategory);
                      _selectedCategory = newCategory;
                      widget.onSelect(newCategory);
                    }
                    _isOtherSelected = false;
                  });
                },
                child: Text('Ajouter la Catégorie'),
              ),
            ],
          ),
      ],
    );
  }
}
