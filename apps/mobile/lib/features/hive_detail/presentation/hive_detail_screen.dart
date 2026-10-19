import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:queenbee/core/router.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/core/widgets/state_views.dart';
import 'package:queenbee/data/repositories/hive_repository.dart';
import 'package:queenbee/features/hives/domain/hive.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

final hiveProvider = StreamProvider.family<Hive?, String>(
  (ref, id) => ref.watch(hiveRepositoryProvider).watchHive(id),
);

/// Détail d'une ruche : poids, score de santé, graphe sur 7 jours, accès à l'inspection (UC-A01).
///
/// États : chargement, erreur, ruche introuvable (vide), hors-ligne (dernières données + date).
/// Accessibilité : le graphe `fl_chart` N'EST PAS lisible par un lecteur d'écran -> ajouter un
/// résumé texte (« Poids en baisse de 0,4 kg en 7 jours ») dans un widget `Semantics`.
///
/// TODO(KAN-xxx, EP-07) :
///  - carte « poids actuel » et « score de santé » (jauge + texte, pas la couleur seule) ;
///  - graphe `fl_chart` des 7 derniers jours (liste de `WeightPoint` depuis Drift) ;
///  - historique des dernières inspections ; alerte en cours.
class HiveDetailScreen extends ConsumerWidget {
  const HiveDetailScreen({required this.hiveId, super.key});

  final String hiveId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final hive = ref.watch(hiveProvider(hiveId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.hiveDetailTitle)),
      body: hive.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(onRetry: () => ref.invalidate(hiveProvider(hiveId))),
        data: (h) {
          if (h == null) return EmptyView(message: l10n.hivesEmpty);
          return ListView(
            padding: const EdgeInsets.all(QbSpacing.s4),
            children: [
              Text(h.code, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: QbSpacing.s4),
              Text('${l10n.hiveWeight} : ${h.lastWeightKg ?? '-'} kg'),
              Text('${l10n.hiveHealthScore} : ${h.healthScore ?? '-'} / 100'),
              const SizedBox(height: QbSpacing.s6),
              Text(l10n.hiveGraph7d, style: Theme.of(context).textTheme.titleMedium),
              // TODO(KAN-xxx, EP-07) : graphe fl_chart + résumé accessible
              const SizedBox(height: QbSpacing.s6),
              FilledButton.icon(
                icon: const Icon(Icons.edit_note),
                label: Text(l10n.hiveNewInspection),
                onPressed: () => context.go(Routes.newInspection(hiveId)),
              ),
            ],
          );
        },
      ),
    );
  }
}
