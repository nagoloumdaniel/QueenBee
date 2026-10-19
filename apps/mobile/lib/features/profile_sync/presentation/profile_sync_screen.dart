import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/sync/sync_service.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Profil et synchronisation : nombre d'éléments en attente, dernière sync, bouton
/// « Synchroniser maintenant », déconnexion.
///
/// États : en cours de synchronisation (indicateur + texte), échec (message simple + Réessayer),
/// rien à synchroniser, hors-ligne (bouton désactivé avec explication).
/// Accessibilité : le compteur est une `liveRegion` ; le bouton garde son nom pendant le chargement.
///
/// TODO(KAN-xxx, EP-07) : relier `SyncService.syncNow`, afficher `SyncStatus`, ajouter
/// la déconnexion (`AuthController.logout`), la langue et le thème.
class ProfileSyncScreen extends ConsumerWidget {
  const ProfileSyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pending = ref.watch(pendingCountProvider).valueOrNull ?? 0;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(QbSpacing.s6),
        children: [
          Semantics(
            liveRegion: true,
            child: Text(
              l10n.syncPending(pending),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: QbSpacing.s6),
          FilledButton.icon(
            icon: const Icon(Icons.sync),
            label: Text(l10n.syncNow),
            // TODO(KAN-xxx, EP-07) : ref.read(syncServiceProvider).syncNow() avec gestion d'état
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
