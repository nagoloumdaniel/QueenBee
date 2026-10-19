import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/data/local/app_database.dart';
import 'package:uuid/uuid.dart';

/// Outbox : file des écritures locales à envoyer au serveur (ROADMAP §4.8 « sync offline »).
///
/// Principe offline-first :
///  1. l'écran écrit l'entité dans Drift ET une ligne dans l'outbox, dans UNE transaction ;
///  2. l'UI affiche immédiatement l'entité depuis Drift (statut « en attente ») ;
///  3. `SyncService.pushPending()` envoie par lots dès que le réseau revient ;
///  4. le serveur répond par entité : `ok` (supprimer de l'outbox), `conflict` (409 + version
///     serveur -> résolution), `error` (réessayer plus tard avec backoff).
///
/// Idempotence : chaque entité porte un `client_uuid` (UUID v4 généré sur l'appareil). Renvoyer
/// deux fois la même entité ne crée JAMAIS de doublon (upsert serveur par `client_uuid`).
enum OutboxEntityType { inspection, inspectionPhoto, harvest }

enum OutboxStatus { pending, sending, failed }

enum OutboxOperation { create, update }

/// Vue de domaine d'une ligne d'outbox (la table Drift est dans data/local/tables.dart).
class OutboxItem {
  const OutboxItem({
    required this.id,
    required this.entityType,
    required this.clientUuid,
    required this.operation,
    required this.payload,
    required this.status,
    required this.attempts,
    required this.createdAt,
  });

  final int id;
  final OutboxEntityType entityType;
  final String clientUuid;
  final OutboxOperation operation;
  final Map<String, dynamic> payload;
  final OutboxStatus status;
  final int attempts;
  final DateTime createdAt;
}

/// Accès à la file. TODO(KAN-xxx, EP-07) : implémenter avec les DAO Drift (voir
/// data/local/app_database.dart) et couvrir par des tests (test/core/sync/outbox_test.dart).
class OutboxRepository {
  OutboxRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  // ignore: unused_field
  final AppDatabase _db;
  final Uuid _uuid;

  /// Génère l'identifiant d'idempotence d'une nouvelle entité.
  String newClientUuid() => _uuid.v4();

  /// Ajoute une opération à envoyer. À appeler DANS la transaction qui écrit l'entité.
  Future<void> enqueue({
    required OutboxEntityType type,
    required String clientUuid,
    required OutboxOperation operation,
    required Map<String, dynamic> payload,
  }) async {
    // TODO(KAN-xxx, EP-07) : insert dans la table outbox_entries (payload en JSON).
    jsonEncode(payload);
    throw UnimplementedError('TODO(KAN-xxx, EP-07): outbox.enqueue');
  }

  /// Éléments en attente, du plus ancien au plus récent (ordre d'envoi).
  Future<List<OutboxItem>> pending({int limit = 50}) async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): outbox.pending');
  }

  /// Flux du nombre d'éléments non synchronisés (bannière « N éléments à synchroniser »).
  Stream<int> watchPendingCount() {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): outbox.watchPendingCount');
  }

  Future<void> markDone(int outboxId) async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): outbox.markDone');
  }

  Future<void> markFailed(int outboxId, {required String reason}) async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): outbox.markFailed');
  }
}

final outboxRepositoryProvider = Provider<OutboxRepository>(
  (ref) => OutboxRepository(ref.watch(appDatabaseProvider)),
);
