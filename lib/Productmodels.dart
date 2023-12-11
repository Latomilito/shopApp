class Produit {
  final String nom;
  final String description;
  final double prix;
  final int quantiteEnStock;
  final String image;
  final List<String> imagesSupplementaires;
  final String avisClients;
  final String informationsContactVendeur;

  Produit({
    required this.nom,
    required this.description,
    required this.prix,
    required this.quantiteEnStock,
    required this.image,
    required this.imagesSupplementaires,
    required this.avisClients,
    required this.informationsContactVendeur,
  });
}
