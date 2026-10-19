import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/network/connectivity_provider.dart';
import 'package:queenbee/core/sync/sync_service.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Bannière « Hors ligne / N éléments à synchroniser » (ROADMAP §4.7).
/// Annoncée aux lecteurs d'écran (liveRegion) ; invisible quand tout va bien.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final online = ref.watch(isOnlineProvider).valueOrNull ?? true;
    final pending = ref.watch(pendingCountProvider).valueOrNull ?? 0;
    if (online && pending == 0) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final text = online
        ? l10n.syncPending(pending)
        : '${l10n.offlineBanner} - ${l10n.syncPending(pending)}';
    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(QbSpacing.s3),
        color: theme.colorScheme.primary,
        child: Row(
          children: [
            Icon(
              online ? Icons.sync : Icons.cloud_off,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: QbSpacing.s2),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
