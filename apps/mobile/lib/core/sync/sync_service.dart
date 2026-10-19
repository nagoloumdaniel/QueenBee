import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/network/connectivity_provider.dart';
import 'package:queenbee/core/sync/outbox.dart';

/// Résultat d'un cycle de synchronisation (affiché dans l'écran Profil/Sync).
class SyncReport {
  const SyncReport({
    this.pushed = 0,
    this.conflicts = 0,
    this.failed = 0,
    this.pulled = 0,
    this.finishedAt,
  });

  final int pushed;
  final int conflicts;
  final int failed;
  final int pulled;
  final DateTime? finishedAt;
}

/// Service de synchronisation : PUSH de l'outbox puis PULL des changements serveur.
///
/// Séquence (ROADMAP §4.8) :
///  1. `POST /sync/push` (lot d'éléments de l'outbox, JWT) ;
///  2. pour chaque élément : succès -> `markDone` ; 409 -> résolution de conflit ; autre -> retry ;
///  3. `GET /sync/pull?since=<curseur>` -> appliquer dans Drift -> mémoriser le nouveau curseur.
///
/// Règles de résolution de conflit (ADR-0003, ROADMAP §4.9) :
///  - le serveur gagne si l'entité est déjà `validated` ;
///  - sinon fusion champ par champ (le `updated_at` le plus récent l'emporte) ;
///  - photos et notes ne sont JAMAIS écrasées (ajout).
///
/// Déclencheurs : retour du réseau, ouverture de l'app, bouton « Synchroniser maintenant »,
/// tâche périodique (workmanager : TODO). Backoff exponentiel avec plafond ; jamais bloquer l'UI.
/// Performance cible : une journée de données (38 400 mesures côté serveur) en < 2 min.
///
/// TODO(KAN-xxx, EP-07) : implémenter, avec test de propriété sur les règles de fusion.
class SyncService {
  SyncService(this._outbox);

  // ignore: unused_field
  final OutboxRepository _outbox;

  /// Envoie l'outbox. Retourne le nombre d'éléments envoyés avec succès.
  Future<SyncReport> pushPending() async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): sync push');
  }

  /// Récupère les changements depuis le dernier curseur.
  Future<SyncReport> pull() async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): sync pull');
  }

  /// Cycle complet : push puis pull.
  Future<SyncReport> syncNow() async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): sync now');
  }
}

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(ref.watch(outboxRepositoryProvider)),
);

/// Nombre d'éléments en attente (alimente la bannière hors-ligne).
/// Tant que l'outbox n'est pas implémentée, on affiche 0 pour ne pas casser l'UI.
final pendingCountProvider = StreamProvider<int>((ref) {
  try {
    return ref.watch(outboxRepositoryProvider).watchPendingCount();
  } on UnimplementedError {
    return Stream.value(0);
  }
});

/// Lance une synchronisation automatique au retour du réseau.
/// À activer dans `QueenBeeApp` (ref.watch) par le ticket EP-07.
final autoSyncProvider = Provider<void>((ref) {
  ref.listen<AsyncValue<bool>>(isOnlineProvider, (previous, next) {
    final wasOffline = previous?.valueOrNull == false;
    if (wasOffline && next.valueOrNull == true) {
      // TODO(KAN-xxx, EP-07) : ref.read(syncServiceProvider).syncNow();
    }
  });
});
