import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/pages/promotionPage.dart';
import 'package:shopapp/pages/publicationPage.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> liste = ['Nouveaux', 'En cours', 'Terminer'];
  @override
  Widget build(BuildContext context) {
    List<Widget> statistics = [
      StatisticCard(
        title: 'Ajouter un produit',
        icon: Icons.production_quantity_limits,
        onpressed: () {},
      ),
      StatisticCard(
          title: 'Offres spéciale',
          icon: Icons.panorama_wide_angle_outlined,
          onpressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return OfferPublishScreen();
            }));
          }),
      StatisticCard(
        title: 'Clients',
        icon: Icons.person,
        onpressed: () {},
      ),
      StatisticCard(
        title: 'Ajouter un produit',
        icon: Icons.add,
        onpressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return PublicationPage();
          }));
        },
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord de l\'Administrateur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              // color: Colors.blue,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.of(context).size.height / 10),
                itemCount: statistics.length,
                itemBuilder: (BuildContext context, int index) {
                  return statistics[index];
                },
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: liste.length,
                child: Column(
                  children: [
                    TabBar(
                      indicatorWeight: 3,
                      indicatorColor: Colors.orange,
                      isScrollable: true, enableFeedback: true,
                      labelColor: Colors.black,
                      // indicator: ,
                      tabs: liste.map((category) {
                        return Tab(text: category);
                      }).toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: liste.map((e) {
                          return ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (buildContext, index) {
                                return OrderListItem(
                                    onAccept: () {},
                                    onDelete: () {},
                                    onReject: () {},
                                    order: orders[index]);
                              });
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpressed;
  const StatisticCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.acme(fontSize: 15),
              ),
              const SizedBox(height: 5.0),
              Icon(icon)
            ],
          ),
        ),
      ),
    );
  }
}

// Liste de statistiques (peut être remplacée par des données réelles)

class OrderListItem extends StatelessWidget {
  final Map<String, String> order;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onDelete;

  OrderListItem({
    required this.order,
    required this.onAccept,
    required this.onReject,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      color: Colors.cyan.withOpacity(0.4),
      child: ExpansionTile(
        // backgroundColor: Colors.cyan.withOpacity(0.4),
        title: Text('Commande #${order['number']}'),
        subtitle: Text('Date de Commande: ${order['date']}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nom du Client: ${order['client']}'),
                Text('Montant Total: ${order['total']}'),
                const SizedBox(height: 16),
                const Text('Éléments de la Commande:'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    // Construisez ici chaque élément de la liste
                    return const ListTile(
                      title: Text(''),
                      subtitle: Text(''),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed:
                          onAccept, // Appuyez sur ce bouton pour accepter la commande
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed:
                          onReject, // Appuyez sur ce bouton pour refuser la commande
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed:
                          onDelete, // Appuyez sur ce bouton pour supprimer la commande
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> statisticss = [
  // ... Statistiques restantes ...
];

List<Map<String, String>> orders = [
  {
    'number': '001',
    'date': '2023-09-20',
    'client': 'John Doe',
    'total': '\$100.00',
  },
  {
    'number': '002',
    'date': '2023-09-19',
    'client': 'Jane Smith',
    'total': '\$75.50',
  },
  {
    'number': '002',
    'date': '2023-09-19',
    'client': 'Jane Smith',
    'total': '\$75.50',
  },

  // Ajoutez d'autres commandes ici
];

class OrderDetailsDialog extends StatelessWidget {
  final Map<String, String> order;

  OrderDetailsDialog({required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Détails de la Commande #${order['number']}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date de Commande: ${order['date']}'),
          Text('Nom du Client: ${order['client']}'),
          const SizedBox(height: 16),
          const Text('Éléments de la Commande:'),
          const SizedBox(height: 16),
          Text('Montant Total: ${order['total']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fermez le dialogue
          },
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}
