/// Récolte déclarée par l'apiculteur (UC-A03).
class Harvest {
  const Harvest({
    required this.clientUuid,
    required this.hiveId,
    required this.harvestedOn,
    required this.volumeKg,
    this.status = 'declared',
  });

  final String clientUuid;
  final String hiveId;
  final DateTime harvestedOn;

  /// Volume en kilogrammes, >= 0 (contrainte SQL `CHECK (volume_kg >= 0)`).
  final double volumeKg;

  /// declared | validated | flagged (validée ou signalée par le coordinateur).
  final String status;
}
