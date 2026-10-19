import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/core/widgets/state_views.dart';
import 'package:queenbee/data/repositories/alert_repository.dart';
import 'package:queenbee/features/alerts/domain/alert.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

final alertsProvider = StreamProvider<List<HiveAlert>>(
  (ref) => ref.watch(alertRepositoryProvider).watchAlerts(),
);

/// Alertes reçues (UC-A02) : liste triée par gravité puis par date.
///
/// États : chargement, erreur, vide (« Aucune alerte, tout va bien »), hors-ligne.
/// Accessibilité : la gravité est dite en TEXTE et portée par une icône, jamais par la couleur seule.
///
/// TODO(KAN-xxx, EP-07) :
///  - réception des notifications push (FCM, `firebase_messaging`) -> ouverture de l'alerte ;
///  - action « J'ai vu » (accusé de réception) : écrit en local + outbox ;
///  - lien vers la ruche concernée et recommandation en langage simple.
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final alerts = ref.watch(alertsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.alertsTitle)),
      body: alerts.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(onRetry: () => ref.invalidate(alertsProvider)),
        data: (items) {
          if (items.isEmpty) {
            return EmptyView(message: l10n.alertsEmpty, icon: Icons.check_circle_outline);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(QbSpacing.s4),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: QbSpacing.s2),
            itemBuilder: (context, i) {
              final a = items[i];
              return Card(
                child: ListTile(
                  minVerticalPadding: QbSpacing.s3,
                  leading: Icon(
                    a.severity == AlertSeverity.critical
                        ? Icons.error
                        : Icons.warning_amber,
                  ),
                  title: Text(a.type),
                  subtitle: Text(a.recommendation ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
