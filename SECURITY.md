# Politique de sécurité

## Signaler une vulnérabilité
Ne créez **pas** d'issue publique. Contactez l'administrateur du projet (LH, propriétaire du dépôt, via son compte GitHub `nagoloumdaniel`) en message privé, ou utilisez la fonction « Report a vulnerability » (GitHub Security Advisories) si elle est activée sur le dépôt.

Indiquez : composant concerné, étapes de reproduction, impact estimé, version/commit. **N'incluez aucun secret ni donnée personnelle réelle.** Accusé de réception visé sous 5 jours ouvrés.

## Périmètre
Tout le code du dépôt (apps, infra, workflows). Sont hors périmètre : tests de charge ou d'intrusion sur des environnements qui ne vous appartiennent pas, déni de service, ingénierie sociale, attaque de l'hébergeur.

## Règles pour les contributeurs
- Aucun secret dans le dépôt, les logs ou les images (Gitleaks en pre-commit et en CI). Un secret committé par erreur est **considéré compromis** : le révoquer et le remplacer, ne pas se contenter de le supprimer.
- Les tests actifs de sécurité (ZAP, fuzzing, brute force) se font **uniquement en environnement de test**, jamais en production.
- Dépendances : Snyk, Trivy et Dependabot ; pas de vulnérabilité critique non traitée à la fusion.
- Référentiel de revue : OWASP ASVS niveau 2 (`docs/security/asvs-checklist.md`) ; conformité : `docs/compliance/`.
- Données personnelles : minimisation, chiffrement, aucune PII en clair dans les logs.

## Versions prises en charge
Projet pédagogique en développement : seule la branche `main` est suivie.
