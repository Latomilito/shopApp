import 'package:flutter/material.dart';
import 'package:shopapp/models/productModels.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<Produit> elements;
  final Function(List<Produit> elements) onFilterApplied;

  const FilterBottomSheet({
    super.key,
    required this.elements,
    required this.onFilterApplied,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double _minPrice = 0.0;
  double _maxPrice = 100.0;
  bool _includeOutOfStock = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filtrer les produits'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_minPrice - $_maxPrice',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            RangeSlider(
              divisions: 20,
              values: RangeValues(_minPrice, _maxPrice),
              min: 0.0,
              max: 20000.0,
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _includeOutOfStock,
                  onChanged: (bool? value) {
                    setState(() {
                      _includeOutOfStock = value ?? false;
                    });
                  },
                ),
                const Text('Inclure les produits en rupture de stock'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Appliquer les filtres à la liste d'origine
                List<Produit> listeFiltree = widget.elements
                    .where((produit) =>
                        produit.prix! >= _minPrice &&
                        produit.prix! <= _maxPrice)
                    .toList();

                // Appeler la fonction de rappel pour renvoyer la liste filtrée
                widget.onFilterApplied(listeFiltree);

                // Fermer le BottomSheet
                Navigator.of(context).pop();
              },
              child: const Text('Appliquer les filtres'),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltreWidget extends StatefulWidget {
  final List<Produit> elements;
  final Function(List<Produit> elements) onFiltreApplique;

  const FiltreWidget({
    super.key,
    required this.elements,
    required this.onFiltreApplique,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FiltreWidgetState createState() => _FiltreWidgetState();
}

class _FiltreWidgetState extends State<FiltreWidget> {
  final TextEditingController _controller = TextEditingController();

  void _afficherFiltres(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FilterBottomSheet(
          elements: widget.elements,
          onFilterApplied: (listeFiltree) {
            setState(() {
              widget.onFiltreApplique(listeFiltree);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    controller: _controller,
                    onChanged: (query) {
                      filtrer();
                    },
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      hintText: 'Rechercher une catégorie ou un nom de produit',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(10),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                _afficherFiltres(context);
              },
              child: const Icon(
                Icons.filter_list,
                color: Colors.red,
              ),
            )
          ],
        ),
      ],
    );
  }

  void filtrer() {
    List<Produit> listeFiltree = widget.elements
        .where((element) =>
            element.nom!
                .toLowerCase()
                .contains(_controller.text.toLowerCase()) ||
            element.categorie!
                .toLowerCase()
                .contains(_controller.text.toLowerCase()))
        .toList();

    widget.onFiltreApplique(listeFiltree);
  }
}
