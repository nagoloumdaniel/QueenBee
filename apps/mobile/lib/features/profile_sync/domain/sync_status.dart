/// État de synchronisation affiché dans l'écran Profil / Sync.
class SyncStatus {
  const SyncStatus({
    this.pendingCount = 0,
    this.lastSyncAt,
    this.lastError,
    this.isSyncing = false,
  });

  /// Éléments de l'outbox pas encore envoyés.
  final int pendingCount;
  final DateTime? lastSyncAt;

  /// Message simple (pas de trace technique) du dernier échec, s'il y en a un.
  final String? lastError;
  final bool isSyncing;
}
