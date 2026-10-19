# Seeds

Données de départ chargées après les migrations (script à écrire : EP-02 [DB], p. ex. `python -m app.seeds` côté API).

| Fichier | Contenu |
|---|---|
| `sites.yaml` | 3 pays et 8 sites avec position et profil climatique (aligné sur `apps/simulator/config/sites.yaml`) |
| `coops.yaml` | 16 coopératives (2 par site) avec la cible d'apiculteurs par coopérative |

## Volumétrie cible

| Entité | Nombre | Génération |
|---|---|---|
| Pays / sites | 3 / 8 | fichier `sites.yaml` |
| Coopératives | 16 | fichier `coops.yaml` |
| Ruches | 400 (50 par site) | générées : code `SN-CASA-001` ... `-050`, position autour du site, `qr_token` aléatoire |
| Utilisateurs | 317 | 296 apiculteurs (somme de `beekeepers` dans `coops.yaml`), 16 coordinateurs (2 par site), 4 gestionnaires, 1 admin |

La répartition des 317 utilisateurs est une proposition à valider (la ROADMAP ne fixe que le total).

## Règles

- **Aucun secret** : mots de passe de démo lus depuis une variable d'environnement (`SEED_DEMO_PASSWORD`), hachés en argon2id au chargement ; MFA TOTP activée avant usage pour les rôles privilégiés.
- Données fictives uniquement (noms générés), aucune donnée personnelle réelle (RGPD).
- Les seeds doivent être idempotents (rejouables sans doublon) et déterministes (graine fixe).
