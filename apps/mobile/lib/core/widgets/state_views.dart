import 'package:flutter/material.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Les 3 états à dessiner sur CHAQUE écran (le 4e, « hors ligne », est la bannière
/// globale `OfflineBanner`). PLAYBOOK §6 : un écran sans ces états n'est pas « Done ».

/// État de chargement.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Semantics(
        label: l10n.commonLoading,
        liveRegion: true,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

/// État d'erreur avec action « Réessayer » (cible >= 48 dp).
class ErrorView extends StatelessWidget {
  const ErrorView({this.message, this.onRetry, super.key});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(QbSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: QbSpacing.s3),
            Semantics(
              liveRegion: true,
              child: Text(
                message ?? l10n.commonError,
                textAlign: TextAlign.center,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: QbSpacing.s4),
              FilledButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
            ],
          ],
        ),
      ),
    );
  }
}

/// État vide : icône + phrase courte et rassurante.
class EmptyView extends StatelessWidget {
  const EmptyView({required this.message, this.icon = Icons.inbox_outlined, super.key});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(QbSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: QbSpacing.s3),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
