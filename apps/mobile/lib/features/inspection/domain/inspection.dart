/// Inspection d'une ruche saisie sur le terrain (UC-A01).
///
/// `clientUuid` est généré sur l'appareil : il rend l'envoi idempotent (ROADMAP §4.9).
class Inspection {
  const Inspection({
    required this.clientUuid,
    required this.hiveId,
    required this.inspectedAt,
    this.visualState,
    this.queenPresent,
    this.behavior,
    this.notes,
    this.anomaly = false,
    this.photoPaths = const [],
    this.version = 1,
  });

  final String clientUuid;
  final String hiveId;
  final DateTime inspectedAt;
  final String? visualState;
  final bool? queenPresent;
  final String? behavior;
  final String? notes;

  /// Vrai si l'apiculteur signale une anomalie : le coordinateur est notifié après sync.
  final bool anomaly;

  /// Chemins locaux des photos (redimensionnées/WebP avant envoi).
  final List<String> photoPaths;
  final int version;
}
