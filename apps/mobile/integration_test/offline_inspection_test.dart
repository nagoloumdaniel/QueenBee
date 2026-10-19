import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// E2E EP-07 « app offline » (ROADMAP §5.4b) - SQUELETTE à compléter par le ticket EP-07.
///
/// Scénario exigé :
///   1. mode avion ACTIVÉ ;
///   2. l'apiculteur (déjà connecté) crée une inspection avec photo sur une ruche ;
///   3. l'inspection s'affiche immédiatement avec le statut « en attente » ;
///   4. mode avion DÉSACTIVÉ -> la synchronisation part toute seule ;
///   5. l'inspection est « synchronisée » et le coordinateur est notifié (vérifié via l'API de test) ;
///   6. variante : conflit simulé (modification serveur entre-temps) -> résolution attendue.
///
/// Comment basculer le réseau en test :
///  - Patrol (https://patrol.leancode.co) pour piloter le mode avion de l'appareil/émulateur, ou
///  - une couche réseau injectable (fausse `Dio` + faux `isOnlineProvider`) pour un test déterministe.
/// Lancer : `flutter test integration_test/offline_inspection_test.dart -d <appareil>`
/// Environnement : stack Compose e2e (infra/compose/e2e.yml) + simulateur pour les données.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UC-A01 - inspection hors ligne', () {
    testWidgets(
      'crée une inspection en mode avion puis la synchronise au retour du réseau',
      (tester) async {
        // TODO(KAN-xxx, EP-07) : démarrer l'app avec une session de test, couper le réseau,
        // saisir l'inspection + photo, vérifier le statut « en attente », rétablir le réseau,
        // attendre la fin de la sync, vérifier le statut « synchronisée » et l'absence de doublon.
      },
      skip: true,
    );

    testWidgets(
      'résout un conflit de synchronisation selon les règles de l\'ADR-0003',
      (tester) async {
        // TODO(KAN-xxx, EP-07)
      },
      skip: true,
    );
  });
}
