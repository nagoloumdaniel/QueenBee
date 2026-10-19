# test/features

Un sous-dossier par feature, miroir de `lib/features/` : `test/features/hives/hives_screen_test.dart`, etc.

Chaque écran doit avoir au minimum un **test widget** qui vérifie :
- les 3 états (chargement, erreur avec bouton Réessayer, vide) avec un repository factice (`mocktail`) ;
- l'accessibilité : `tester.ensureSemantics()` puis `expect(tester, meetsGuideline(androidTapTargetGuideline))` et `labeledTapTargetGuideline` ;
- les textes viennent de la localisation (pas de chaîne en dur).

Lancer : `flutter test`.
