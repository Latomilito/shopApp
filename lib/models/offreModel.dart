class Offre {
  final String id;
  final String utilisateurId;
  final String produitId;
  final double montantPropose;
  final DateTime dateProposition;

  Offre({
    required this.id,
    required this.utilisateurId,
    required this.produitId,
    required this.montantPropose,
    required this.dateProposition,
  });
}
