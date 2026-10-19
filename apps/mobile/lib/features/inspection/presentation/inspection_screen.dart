import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Nouvelle inspection : assistant en 4 étapes + photo (UC-A01, ROADMAP §4.7).
///
/// Étapes prévues : 1) aspect général  2) reine et comportement  3) photo  4) notes et confirmation.
/// Principe OFFLINE-FIRST : « Enregistrer » écrit dans Drift + outbox et affiche tout de suite
/// `inspectionSavedOffline` ; AUCUN appel réseau ici. Test : integration_test/offline_inspection_test.dart.
///
/// États : brouillon conservé si l'app est fermée (TODO), erreur d'écriture locale, appareil photo
/// refusé (alternative sans photo), hors-ligne (aucun blocage).
/// Accessibilité : une action principale par écran, boutons >= 48 dp, saisie minimale
/// (choix à pictogrammes + mots plutôt que du texte libre), `Semantics` sur l'étape courante.
///
/// TODO(KAN-xxx, EP-07) : formulaires de chaque étape, `image_picker` (photo -> redimension),
/// `InspectionRepository.saveInspection`, retour vers le détail avec confirmation.
class InspectionScreen extends ConsumerStatefulWidget {
  const InspectionScreen({required this.hiveId, super.key});

  final String hiveId;

  @override
  ConsumerState<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends ConsumerState<InspectionScreen> {
  static const _totalSteps = 4;
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLast = _step == _totalSteps - 1;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.inspectionTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(QbSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                liveRegion: true,
                child: Text(
                  l10n.inspectionStepOf(_step + 1, _totalSteps),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: QbSpacing.s2),
              LinearProgressIndicator(value: (_step + 1) / _totalSteps),
              const Expanded(
                // TODO(KAN-xxx, EP-07) : contenu de l'étape courante
                child: Center(child: Text('TODO(KAN-xxx, EP-07)')),
              ),
              Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _step--),
                        child: Text(l10n.inspectionBack),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: QbSpacing.s3),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (isLast) {
                          // TODO(KAN-xxx, EP-07) : saveInspection + SnackBar inspectionSavedOffline
                        } else {
                          setState(() => _step++);
                        }
                      },
                      child: Text(isLast ? l10n.inspectionSave : l10n.inspectionNext),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
