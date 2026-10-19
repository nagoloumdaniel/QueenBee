# core/auth

Session de l'apiculteur : `auth_controller.dart` (Riverpod `Notifier`).

Points clés à implémenter (epic EP-07, dépend de EP-03 côté API) :
- login + MFA (TOTP), message d'erreur **générique** ;
- jetons dans le stockage sécurisé (`core/storage`), jamais ailleurs ;
- **session restaurée sans réseau** au démarrage (l'app doit s'ouvrir en mode avion) ;
- refresh rotatif : une réutilisation d'ancien refresh révoque la famille (côté API) -> prévoir le retour au login ;
- device binding : envoyer un `device_id` stable (généré, stocké en secure storage).

Test attendu : `integration_test/offline_inspection_test.dart` (démarrage hors ligne authentifié).
