import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Déclaration d'une récolte (UC-A03) : ruche + volume (kg) + date.
///
/// Même principe que l'inspection : écriture locale + outbox, confirmation immédiate, envoi plus tard.
/// Le coordinateur valide ensuite (UC-C02) ; un grand écart avec la prévision peut être signalé.
///
/// États : chargement du formulaire, erreur de saisie (volume négatif, champ vide) annoncée au
/// lecteur d'écran, succès confirmé, hors-ligne (aucun blocage).
/// Accessibilité : clavier numérique, libellé avec unité, bouton >= 48 dp.
///
/// TODO(KAN-xxx, EP-07) : sélection de la ruche, champ volume validé, `HarvestRepository.declare`,
/// liste des dernières récoltes avec leur statut (déclarée / validée / signalée).
class HarvestScreen extends ConsumerStatefulWidget {
  const HarvestScreen({super.key});

  @override
  ConsumerState<HarvestScreen> createState() => _HarvestScreenState();
}

class _HarvestScreenState extends ConsumerState<HarvestScreen> {
  final _volume = TextEditingController();

  @override
  void dispose() {
    _volume.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.harvestTitle)),
      body: ListView(
        padding: const EdgeInsets.all(QbSpacing.s6),
        children: [
          TextField(
            controller: _volume,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.harvestVolumeKg),
          ),
          const SizedBox(height: QbSpacing.s6),
          FilledButton(
            // TODO(KAN-xxx, EP-07) : valider puis HarvestRepository.declare
            onPressed: () {},
            child: Text(l10n.harvestSubmit),
          ),
        ],
      ),
    );
  }
}
