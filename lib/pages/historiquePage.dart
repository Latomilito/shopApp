import 'package:flutter/material.dart';

// Modèle de données pour l'historique des commandes
class Order {
  final String orderId;
  final DateTime orderDate;
  final List<Product> products;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.products,
  });
}

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
}

class HistoriquePage extends StatefulWidget {
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  // Liste d'historique des commandes (remplacez par vos données réelles)
  List<Order> orders = [
    Order(
      orderId: '12345',
      orderDate: DateTime(2023, 9, 1),
      products: [
        Product(name: 'Produit A', price: 10.0),
        Product(name: 'Produit B', price: 15.0),
      ],
    ),
    // Ajoutez d'autres commandes ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Historique',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              color: Colors.grey.withOpacity(0.2),
              elevation: 0,
              child: ListTile(
                title: Text('Commande #${order.orderId}'),
                subtitle: Text('Date: ${order.orderDate.toString()}'),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  _showOrderDetails(order);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Affichez les détails de la commande dans une boîte de dialogue
  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Détails de la Commande #${order.orderId}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Date de la Commande: ${order.orderDate.toString()}'),
              const SizedBox(height: 8),
              const Text('Produits Commandés:'),
              Column(
                children: order.products
                    .map((product) => ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                              'Prix: \$${product.price.toStringAsFixed(2)}'),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  // Ajoutez ici la logique pour renouveler la commande
                },
                child: const Text(
                  'Ajouter au panier à nouveau',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
