/// Ruche telle que l'interface la voit (indépendante de Drift et de l'API).
class Hive {
  const Hive({
    required this.id,
    required this.code,
    required this.siteId,
    this.latitude,
    this.longitude,
    this.lastWeightKg,
    this.healthScore,
  });

  final String id;

  /// Code lisible, ex. `SN-CASA-014`.
  final String code;
  final String siteId;
  final double? latitude;
  final double? longitude;
  final double? lastWeightKg;

  /// Score de santé de 0 à 100 (fourni par le serveur / l'équipe Data), null si inconnu.
  final int? healthScore;
}
