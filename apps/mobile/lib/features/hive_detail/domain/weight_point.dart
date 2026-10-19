/// Un point du graphique de poids sur 7 jours (agrégat horaire côté serveur).
class WeightPoint {
  const WeightPoint({required this.at, required this.weightKg});

  final DateTime at;
  final double weightKg;
}
