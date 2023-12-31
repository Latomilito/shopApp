import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferPublishScreen extends StatefulWidget {
  const OfferPublishScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OfferPublishScreenState createState() => _OfferPublishScreenState();
}

class _OfferPublishScreenState extends State<OfferPublishScreen> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  List<String> _selectedProducts = [];

  // Placeholder for product list (you should replace this with your actual product list)
  final List<String> _allProducts = [
    "Product A",
    "Product B",
    "Product C",
    "Product D"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Publier une Offre',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
                onPressed: () => _selectProducts(context),
                child: const Text('Sélectionner les Produits'),
              ),
              const SizedBox(height: 16.0),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description de la Promotion',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Pourcentage de Réduction',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                title: const Text('Date de Début'),
                subtitle: _selectedStartDate == null
                    ? null
                    : Text('${_selectedStartDate!.toLocal()}'),
                onTap: () => _selectStartDate(context),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: const Text('Date de Fin'),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                subtitle: _selectedEndDate == null
                    ? null
                    : Text('${_selectedEndDate!.toLocal()}'),
                onTap: () => _selectEndDate(context),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
                onPressed: () => _publishOffer(),
                child: const Text(
                  'Publier l\'Offre',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectProducts(BuildContext context) async {
    // You can replace this with your product selection logic or navigation to another page.
    List<String>? selectedProducts = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductSelectionScreen(allProducts: _allProducts),
      ),
    );

    if (selectedProducts != null) {
      setState(() {
        _selectedProducts = selectedProducts;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  void _publishOffer() {
    // Validate input and publish the offer to Firestore
    // ...

    // Reset state after publishing
    _imageController.clear();
    _descriptionController.clear();
    _discountController.clear();
    _selectedStartDate = null;
    _selectedEndDate = null;
    _selectedProducts.clear();
  }
}

class ProductSelectionScreen extends StatelessWidget {
  final List<String> allProducts;

  ProductSelectionScreen({required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner les Produits'),
      ),
      body: ListView.builder(
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allProducts[index]),
            onTap: () {
              Navigator.pop(context, [allProducts[index]]);
            },
          );
        },
      ),
    );
  }
}
