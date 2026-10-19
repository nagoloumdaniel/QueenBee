import 'package:flutter_test/flutter_test.dart';

/// Tests unitaires de l'outbox et de la résolution de conflit (squelette).
///
/// À écrire AVANT le code (TDD) par le ticket EP-07 :
///  - une écriture crée l'entité ET la ligne d'outbox dans la même transaction ;
///  - renvoyer deux fois le même `client_uuid` ne crée pas de doublon côté serveur (fausse API) ;
///  - conflit : le serveur gagne si l'entité est `validated` ;
///  - conflit : sinon fusion champ par champ (`updated_at` le plus récent) ;
///  - photos et notes ne sont jamais écrasées (ajout) ;
///  - backoff exponentiel plafonné après échecs réseau.
/// Base : `AppDatabase.forTesting(NativeDatabase.memory())` et `mocktail` pour l'API.
void main() {
  group('Outbox', () {
    test('enqueue écrit entité et outbox dans une transaction', () {}, skip: 'TODO(KAN-xxx, EP-07)');
    test('renvoi idempotent par client_uuid', () {}, skip: 'TODO(KAN-xxx, EP-07)');
  });

  group('Résolution de conflit', () {
    test('le serveur gagne si validé', () {}, skip: 'TODO(KAN-xxx, EP-07)');
    test('fusion champ par champ sinon', () {}, skip: 'TODO(KAN-xxx, EP-07)');
    test('photos et notes jamais écrasées', () {}, skip: 'TODO(KAN-xxx, EP-07)');
  });
}
