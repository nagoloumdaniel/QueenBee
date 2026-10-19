# Checklist sécurité - OWASP ASVS 4.0.3, niveau 2 (adapté à QueenBee)

> Checklist de référence pour la revue sécurité **de chaque tâche** (agent `security-auditor`, DoD). Elle n'est **pas** un audit exhaustif : ne jamais annoncer « audit complet » à partir de scanners seuls. Tests actifs (ZAP, fuzzing, brute force) : **environnements de test uniquement, jamais en production**. ROADMAP §5.7.
> Légende : [ ] à faire - [x] vérifié avec preuve (lien test/rapport) - [N/A] justifié.

## V1 Architecture, conception, modélisation des menaces
- [ ] Modèle de menaces par flux (capteur -> broker -> ingestion, app -> API, web -> API) tenu à jour (STRIDE).
- [ ] Composants sans privilège excessif (conteneurs non-root, comptes de service dédiés).
- [ ] Séparation des environnements et des secrets (dev / staging / prod).

## V2 Authentification
- [ ] Mots de passe hachés **argon2id** ; longueur minimale, pas de règles de composition absurdes ; vérification contre mots de passe compromis (optionnel).
- [ ] **MFA TOTP** obligatoire pour `coordinator`, `manager`, `admin`.
- [ ] Verrouillage après **5 échecs** ; messages d'erreur génériques ; **429** sur login (rate limit).
- [ ] Récupération de compte sûre (jeton à usage unique, expiration courte).
- [ ] Authentification des capteurs : clé par ruche (HMAC), anti-rejeu `seq`.

## V3 Gestion des sessions
- [ ] JWT d'accès **15 min** ; refresh **rotatif** avec détection de réutilisation (révocation de la famille).
- [ ] Cookies web `httpOnly`, `Secure`, `SameSite` ; jamais de jeton dans `localStorage`.
- [ ] Déconnexion = révocation côté serveur ; device binding (`device_id`).

## V4 Contrôle d'accès
- [ ] Autorisation **côté serveur** à chaque requête (RBAC) + **RLS PostgreSQL par site** ; refus par défaut.
- [ ] Tests **IDOR automatisés par rôle** (matrice rôle x ressource) - E2E EP-03.
- [ ] Les contrôles côté web/mobile (masquage de menus, middleware) sont de l'UX, pas de la sécurité.
- [ ] Principe du moindre privilège : `manager` ne modifie pas ce que seul `admin` peut.

## V5 Validation, assainissement, encodage
- [ ] Validation stricte des entrées (Pydantic v2 strict) ; plages physiques des mesures.
- [ ] Requêtes **paramétrées** (aucune concaténation SQL) ; pas de SQL dans les routers.
- [ ] Encodage de sortie / échappement (anti-XSS) ; **CSP stricte** ; pas de `dangerouslySetInnerHTML` avec données utilisateur.
- [ ] Pas d'injection de commande / de chemin ; SSRF : listes blanches pour les appels sortants (n8n, webhooks).
- [ ] Désérialisation sûre (pas de pickle).

## V6 Cryptographie au repos
- [ ] Chiffrement du disque + colonnes PII (pgcrypto) ; clés hors dépôt (SOPS/age, GitHub Secrets).
- [ ] **SQLite mobile chiffré (SQLCipher)** ; clé dans Keystore/Keychain.
- [ ] Algorithmes standards uniquement ; rotation des clés documentée.

## V7 Gestion des erreurs et journalisation
- [ ] Erreurs **RFC 9457** sans détail interne ; pas de trace de pile exposée.
- [ ] Logs JSON structurés avec `trace_id` ; **aucune PII ni secret en clair** dans les logs.
- [ ] Journal d'audit **append-only** (REVOKE UPDATE, DELETE) ; accessible à l'admin en lecture.

## V8 Protection des données
- [ ] Minimisation, consentement (`consent_at`), durée de rétention, droit à l'effacement (voir `docs/compliance/rgpd-registre.md`).
- [ ] Cache HTTP : pas de données privées en cache partagé (`Cache-Control: private, no-store`).
- [ ] Photos : type réel vérifié, taille limitée, **ré-encodage**, métadonnées EXIF nettoyées ; ClamAV optionnel.

## V9 Communications
- [ ] **TLS 1.3**, HSTS ; certificats valides (alerte < 14 j) ; mTLS ou certificats pour les passerelles.
- [ ] **VPN WireGuard** site-central ; MQTT avec TLS, ACL par site, pas d'accès anonyme.
- [ ] CORS en liste blanche ; en-têtes de sécurité (X-Content-Type-Options, X-Frame-Options, Referrer-Policy).

## V10 Code malveillant
- [ ] Revue des dépendances ; versions épinglées ; Dependabot ; pas de code dynamique non maîtrisé.
- [ ] Scripts tiers inspectés avant exécution ; pas de secret dans le dépôt (**Gitleaks** en pre-commit et CI).

## V11 Logique métier
- [ ] Anti-rejeu et idempotence (`client_uuid`, `Idempotency-Key`, `ON CONFLICT DO NOTHING`).
- [ ] Contrôle des abus : limites de volume, de fréquence ; règles de conflit de sync (ADR-0003).
- [ ] Détection de déplacement de ruche (GPS > `tolerance_m`) et de brouillage (UC-CY03/CY04).

## V12 Fichiers et ressources
- [ ] Upload : taille max, types magiques, stockage hors racine web, noms générés ; pas d'exécution.

## V13 API
- [ ] Contrat OpenAPI respecté (**Schemathesis**, pas de 500) ; versionnement `/api/v1` ; pagination bornée.
- [ ] Rate limiting (slowapi + Caddy) ; `/metrics` et `/sim/*` non exposés publiquement.

## V14 Configuration
- [ ] Images **signées** (cosign), SBOM CycloneDX archivé, scans **Snyk / Trivy / Checkov** sans critique ni haute non acceptée.
- [ ] Configuration par variables d'environnement (12-factor) ; secrets jamais dans les images ni les logs.
- [ ] Sauvegardes chiffrées et restauration testée (`docs/runbooks/restore-database.md`).

## Suivi des constats
| ID | Date | Constat | Gravité | Chapitre ASVS | Corrigé dans (PR) | Test de non-régression |
|---|---|---|---|---|---|---|
| | | | | | | |
