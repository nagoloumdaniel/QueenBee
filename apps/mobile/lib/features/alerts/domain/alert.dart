/// Gravité d'une alerte (enum SQL `severity`).
enum AlertSeverity { info, warning, critical }

/// Alerte de risque sur une ruche (UC-A02). Nommée `HiveAlert` pour éviter la
/// collision avec la table Drift `Alerts` et le widget `AlertDialog`.
class HiveAlert {
  const HiveAlert({
    required this.id,
    required this.type,
    required this.severity,
    required this.status,
    required this.detectedAt,
    this.hiveId,
    this.recommendation,
  });

  final String id;
  final String? hiveId;

  /// Valeur de l'enum SQL `alert_type` (swarming, weak_colony, ...).
  final String type;
  final AlertSeverity severity;

  /// Valeur de l'enum SQL `alert_status` (open, acknowledged, ...).
  final String status;
  final String? recommendation;
  final DateTime detectedAt;
}
