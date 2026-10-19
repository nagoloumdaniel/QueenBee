# apps/mobile - Application terrain QueenBee (Flutter)

Application **offline-first** pour les apiculteurs (~300 utilisateurs, appareils Android modestes, réseau intermittent).
Stack : **Flutter + Riverpod + Drift (SQLite chiffré SQLCipher) + Dio + go_router**. Epic : **EP-07**. Règles communes : `docs/jira/PLAYBOOK.md`.

> Ce squelette a été écrit **sans lancer Flutter** : il faut générer les projets natifs et le code généré avant de compiler (voir ci-dessous).

## Démarrer
```bash
cd apps/mobile
flutter create . --project-name queenbee --org org.beeafrica --platforms android,ios   # une seule fois (voir android/README.md)
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Drift (*.g.dart)
flutter gen-l10n                                            # lib/l10n/gen/app_localizations.dart
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1
```
Qualité : `flutter analyze` · `dart format .` · `flutter test` · `flutter test integration_test`.
Après le premier `pub get`, committer `pubspec.lock` et vérifier les versions (`flutter pub outdated`).

## Carte du code (`lib/`)
| Chemin | Rôle |
|---|---|
| `main.dart`, `app.dart` | Démarrage, thème, localisation, routeur |
| `core/router.dart` | Navigation `go_router` + garde d'authentification |
| `core/theme/` | **Tokens** de design (miel/terre/feuille...) et `ThemeData` clair/sombre |
| `core/network/` | Client Dio, état du réseau |
| `core/storage/` | Secrets (Keystore/Keychain) |
| `core/auth/` | Session de l'apiculteur |
| `core/sync/` | **Outbox + SyncService** : le cœur de l'offline-first |
| `core/widgets/` | Cadre des onglets, bannière hors-ligne, états chargement/erreur/vide |
| `data/local/` | Tables et base **Drift** chiffrée |
| `data/remote/` | Appels API |
| `data/repositories/` | Frontière UI <-> données (lire = Drift, écrire = Drift + outbox) |
| `features/<x>/{domain,presentation}` | Un écran par fonctionnalité (voir `lib/features/README.md`) |
| `l10n/app_fr.arb` | Textes en français (prêt pour d'autres langues) |

## Principes (à ne pas casser)
1. **La base locale est la source de l'interface.** Aucun écran n'attend le réseau.
2. Toute écriture = transaction Drift (entité + outbox). Envoi idempotent par `client_uuid`.
3. Secrets (jetons, clé SQLCipher) uniquement dans le stockage sécurisé.
4. Tokens de design uniquement ; pas de couleur en dur. Les mêmes valeurs que le web.
5. Accessibilité (TalkBack/VoiceOver) : `Semantics`, cibles >= 48 dp, pas d'information par la couleur seule, `MediaQuery.disableAnimations` respecté.
6. États **chargement / erreur / vide / hors-ligne** dessinés sur chaque écran.
7. Budget : APK < 30 Mo, images WebP redimensionnées avant envoi.

## Tests
- `test/` : unitaires et widgets (`flutter_test`, `mocktail`).
- `integration_test/offline_inspection_test.dart` : le parcours exigé par EP-07 (mode avion -> inspection + photo -> réseau -> synchronisée).

## Hors périmètre du squelette
Firebase (`google-services.json`, à ne pas committer), polices Inter/Fraunces à embarquer, icônes d'application, signature de release.
