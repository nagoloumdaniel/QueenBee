# features

Un dossier par **fonctionnalité** de l'application terrain. Chaque feature a deux couches :

- `domain/` : objets métier en Dart pur (aucun import Flutter/Drift/Dio).
- `presentation/` : écrans et providers Riverpod. **Un fichier écran par feature.**

| Feature | Écran | Use case | Epic / zone |
|---|---|---|---|
| `auth` | `login_screen.dart` | UC-T01 connexion | EP-07 (dépend EP-03) |
| `hives` | `hives_screen.dart` | UC-A01 liste, carte, QR | EP-07 |
| `hive_detail` | `hive_detail_screen.dart` | UC-A01 détail, graphe 7 j | EP-07 |
| `inspection` | `inspection_screen.dart` | UC-A01 stepper + photo, offline | EP-07 |
| `alerts` | `alerts_screen.dart` | UC-A02 alertes, push FCM | EP-07 |
| `harvest` | `harvest_screen.dart` | UC-A03 déclaration de récolte | EP-07 |
| `profile_sync` | `profile_sync_screen.dart` | UC-T01 sync, profil, déconnexion | EP-07 |

## Règles communes
1. Un écran **lit** via un repository (`data/repositories`), jamais via Dio ni Drift directement.
2. Chaque écran dessine **chargement / erreur / vide** (`core/widgets/state_views.dart`) ; le **hors-ligne** est la bannière globale.
3. Textes dans `lib/l10n/app_fr.arb` (pas de chaîne en dur), couleurs/espacements via `core/theme/tokens.dart` (pas de `Color(0x...)`).
4. Accessibilité : `Semantics` sur tout élément interactif non standard, cibles >= 48 dp, ne jamais coder l'information par la couleur seule, tester avec TalkBack.
5. Widgets petits et `const` quand possible ; extraire un widget dès qu'un `build` dépasse ~80 lignes.
6. Un test widget par écran (`test/features/<feature>/`) et le parcours critique en `integration_test/`.
