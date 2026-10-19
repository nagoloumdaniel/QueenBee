import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:queenbee/core/router.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/core/widgets/state_views.dart';
import 'package:queenbee/data/repositories/hive_repository.dart';
import 'package:queenbee/features/hives/domain/hive.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Liste des ruches de l'apiculteur, lue depuis la base locale (UC-A01).
final hivesProvider = StreamProvider<List<Hive>>(
  (ref) => ref.watch(hiveRepositoryProvider).watchHives(),
);

/// Écran « Mes ruches » : liste + (TODO) carte + scan du QR code.
///
/// États : chargement, erreur (+ Réessayer), vide, hors-ligne (bannière globale).
/// Accessibilité : chaque ruche = une seule cible >= 48 dp avec libellé complet
/// (« Ruche SN-CASA-014, poids 34 kg, santé 82 sur 100 »).
///
/// TODO(KAN-xxx, EP-07) :
///  - carte `flutter_map` + OpenStreetMap avec alternative liste (bascule Liste/Carte) ;
///  - bouton « Scanner un QR code » (`mobile_scanner`) -> GET /hives/by-qr/{token} puis détail ;
///  - tirer pour rafraîchir (`hiveRepository.refresh()`), sans bloquer si hors ligne.
class HivesScreen extends ConsumerWidget {
  const HivesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final hives = ref.watch(hivesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.hivesTitle),
        actions: [
          IconButton(
            tooltip: l10n.hivesScanQr,
            icon: const Icon(Icons.qr_code_scanner),
            // TODO(KAN-xxx, EP-07) : ouvrir l'écran de scan QR
            onPressed: () {},
          ),
        ],
      ),
      body: hives.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(onRetry: () => ref.invalidate(hivesProvider)),
        data: (items) {
          if (items.isEmpty) return EmptyView(message: l10n.hivesEmpty, icon: Icons.hive_outlined);
          return ListView.separated(
            padding: const EdgeInsets.all(QbSpacing.s4),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: QbSpacing.s2),
            itemBuilder: (context, i) {
              final hive = items[i];
              return Semantics(
                button: true,
                label: hive.code,
                child: Card(
                  child: ListTile(
                    minVerticalPadding: QbSpacing.s3,
                    title: Text(hive.code),
                    subtitle: Text(
                      hive.lastWeightKg == null ? '-' : '${hive.lastWeightKg} kg',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.hiveDetail(hive.id)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
